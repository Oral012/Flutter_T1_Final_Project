
import 'package:flutter_test/flutter_test.dart';

import '../../lib/model/user.dart';
import '../../lib/model/user_profile.dart';
import '../../lib/model/weight_goal.dart';
import '../../lib/service/goal_service.dart';

void main() {
  late User user;
  late GoalService goalService;

  setUp(() {
    user = User(name: 'Test User');
    goalService = GoalService();

    goalService.createProfile(
      user,
      const UserProfile(
        age: 25,
        sex: Sex.male,
        heightCm: 175,
        weightKg: 70,
        activityLevel: ActivityLevel.moderate,
      ),
    );
  });

  group('GoalService Tests', () {
    test('G01 - Create valid profile', () {
      expect(user.profile, isNotNull);
      expect(user.profile!.age, 25);
    });

    test('G02 - Reject duplicate profile', () {
      expect(
        () => goalService.createProfile(
          user,
          const UserProfile(
            age: 20,
            sex: Sex.female,
            heightCm: 160,
            weightKg: 50,
            activityLevel: ActivityLevel.low,
          ),
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('G03 - Calculate daily calorie target', () {
      final target = goalService.calculateDailyTarget(
        user.profile!,
        user.weightGoal,
      );

      expect(target, 2594);
    });

    test('G04 - Set valid weight loss goal', () {
      const goal = WeightGoal(
        type: GoalType.lose,
        targetWeightKg: 65,
        weeklyRateKg: 0.5,
      );

      goalService.setWeightGoal(user, goal);

      expect(user.weightGoal.type, GoalType.lose);
      expect(user.weightGoal.targetWeightKg, 65);
    });

    test('G05 - Reject invalid weight loss target', () {
      const goal = WeightGoal(
        type: GoalType.lose,
        targetWeightKg: 75,
        weeklyRateKg: 0.5,
      );

      expect(
        () => goalService.setWeightGoal(user, goal),
        throwsA(isA<Exception>()),
      );
    });

    test('G06 - Calculate duration in weeks', () {
      const goal = WeightGoal(
        type: GoalType.lose,
        targetWeightKg: 65,
        weeklyRateKg: 0.5,
      );

      final duration = goalService.calculateDurationWeeks(
        user.profile!,
        goal,
      );

      expect(duration, 10);
    });
  });
}
