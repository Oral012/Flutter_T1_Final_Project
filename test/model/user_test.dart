
import 'package:flutter_test/flutter_test.dart';
import 'package:nutrition_tracking/model/user.dart';
import 'package:nutrition_tracking/model/weight_goal.dart';
import 'package:nutrition_tracking/model/user_profile.dart';

void main() {
  group('User Model Tests', () {

    test('Should create user with correct name', () {
      final user = User(name: 'Namkea');

      expect(user.name, 'Namkea');
    });

    test('Should have null profile by default', () {
      final user = User(name: 'Namkea');

      expect(user.profile, null);
    });

    test('Should have maintain goal by default', () {
      final user = User(name: 'Namkea');

      expect(user.weightGoal.type, GoalType.maintain);
    });

    test('Should have empty daily logs by default', () {
      final user = User(name: 'Namkea');

      expect(user.logs, isEmpty);
    });

    test('Should assign user profile', () {
      final user = User(name: 'Namkea');

      const profile = UserProfile(
        age: 21,
        sex: Sex.male,
        heightCm: 170,
        weightKg: 65,
        activityLevel: ActivityLevel.moderate,
      );

      user.profile = profile;

      expect(user.profile, isNotNull);
      expect(user.profile!.age, 21);
      expect(user.profile!.weightKg, 65);
    });
  });
}