
import 'package:flutter_test/flutter_test.dart';
import 'package:nutrition_tracking/model/user_profile.dart';

void main() {
  group('UserProfile Model Tests', () {

    test('Should create male user profile', () {
      const profile = UserProfile(
        age: 21,
        sex: Sex.male,
        heightCm: 170,
        weightKg: 65,
        activityLevel: ActivityLevel.moderate,
      );

      expect(profile.age, 21);
      expect(profile.sex, Sex.male);
      expect(profile.heightCm, 170);
      expect(profile.weightKg, 65);
      expect(profile.activityLevel, ActivityLevel.moderate);
    });

    test('Should create female user profile', () {
      const profile = UserProfile(
        age: 22,
        sex: Sex.female,
        heightCm: 160,
        weightKg: 55,
        activityLevel: ActivityLevel.light,
      );

      expect(profile.sex, Sex.female);
      expect(profile.activityLevel, ActivityLevel.light);
    });

    test('Should return correct activity level values', () {
      expect(ActivityLevel.low.value, 1.2);
      expect(ActivityLevel.light.value, 1.375);
      expect(ActivityLevel.moderate.value, 1.55);
      expect(ActivityLevel.high.value, 1.725);
    });
  });
}