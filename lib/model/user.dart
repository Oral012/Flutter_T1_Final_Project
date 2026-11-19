import 'daily_log.dart';
import 'user_profile.dart';
import 'weight_goal.dart';

class User {
  final String name;
  UserProfile? profile;
  WeightGoal weightGoal;
  final List<DailyLog> logs = [];

  User({
    required this.name,
    this.profile,
    this.weightGoal = const WeightGoal(type: GoalType.maintain),
  });
}