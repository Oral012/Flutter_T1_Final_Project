
import '../model/user.dart';
import '../model/user_profile.dart';
import '../model/weight_goal.dart';

class GoalService {
  static const int baseLineCalories = 1200;
  static const double caloriesPerKg = 7700;


void createProfile(User user, UserProfile profile) {
  if (user.profile != null) {
    throw Exception('Profile already exists');
  }
  _validateProfile(profile);
  user.profile = profile;
}

  /// tdee
  double calculateTotalDailyEnergy(UserProfile profile) {
    _validateProfile(profile);
    final base = 10 * profile.weightKg + 6.25 * profile.heightCm - 5 * profile.age;

    final bmr = profile.sex == Sex.male ? base + 5 : base - 161;
    return bmr * profile.activityLevel.value;
  }

  
  int calculateDailyTarget(UserProfile profile, WeightGoal goal) {
    final tdee = calculateTotalDailyEnergy(profile);
    final dailyChange = (goal.weeklyRateKg ?? 0) * caloriesPerKg / 7;
    final target = switch (goal.type) {
      GoalType.lose => tdee - dailyChange,
      GoalType.maintain => tdee,
      GoalType.gain => tdee + dailyChange,
    };
    return target < baseLineCalories ? baseLineCalories : target.round();
  }

  bool isTargetBelowBaseline(UserProfile profile, WeightGoal goal) {
    return calculateDailyTarget(profile, goal) == baseLineCalories;
  }

  void setWeightGoal(User user, WeightGoal goal) {
    if (goal.type != GoalType.maintain) {
      final target = goal.targetWeightKg;
      final rate = goal.weeklyRateKg;
      final weight = user.profile!.weightKg;

      if (target == null || rate == null) {
        throw Exception('Target weight and weekly rate are required');
      }
      if (rate <= 0) {
        throw Exception('Weekly rate must be greater than 0');
      }
      if (goal.type == GoalType.lose && target >= weight) {
        throw Exception('Target weight must be below current weight');
      }
      if (goal.type == GoalType.gain && target <= weight) {
        throw Exception('Target weight must be above current weight');
      }
      if (rate > goal.type.maxWeeklyRateKg(weight)) {
        throw Exception('Weekly rate is above the limit for your weight');
      }
    }
    user.weightGoal = goal;
  }

  double? calculateDurationWeeks(UserProfile profile, WeightGoal goal) {
    final target = goal.targetWeightKg;
    final rate = goal.weeklyRateKg;
    if (goal.type == GoalType.maintain || target == null ||rate == null || rate <= 0) {
      return null;
    }
    return (target - profile.weightKg).abs() / rate;
  }


  void _validateProfile(UserProfile profile) {
    if (profile.age <= 0) throw Exception('Age must be greater than 0');
    if (profile.heightCm <= 0) {
      throw Exception('Height must be greater than 0');
    }
    if (profile.weightKg <= 0) {
      throw Exception('Weight must be greater than 0');
    }
  }
}