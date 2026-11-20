
import 'package:flutter_test/flutter_test.dart';

import '../../lib/model/user.dart';
import '../../lib/model/user_profile.dart';
import '../../lib/service/goal_service.dart';
import '../../lib/service/meal_service.dart';
import '../../lib/service/summary_service.dart';

void main() {
  late User user;
  late GoalService goalService;
  late MealService mealService;
  late SummaryService summaryService;

  final today = DateTime(2026, 11, 20);

  setUp(() {
    user = User(name: 'Test User');

    goalService = GoalService();
    mealService = MealService();
    summaryService = SummaryService();

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

  group('SummaryService Tests', () {
    test('S01 - Calculate total daily calories', () {
      mealService.addMeal(
        user,
        today,
        'Breakfast',
        calories: 500,
      );

      mealService.addMeal(
        user,
        today,
        'Lunch',
        calories: 700,
      );

      final nutrition = summaryService.totalNutrition(
        user,
        today,
      );

      expect(nutrition.calories, 1200);
    });

    test('S02 - Calculate total nutrients', () {
      mealService.addMeal(
        user,
        today,
        'Lunch',
        calories: 500,
        protein: 30,
        carbs: 40,
        fat: 10,
        fiber: 5,
      );

      final nutrition = summaryService.totalNutrition(
        user,
        today,
      );

      expect(nutrition.protein, 30);
      expect(nutrition.carbs, 40);
      expect(nutrition.fat, 10);
      expect(nutrition.fiber, 5);
    });

    test('S03 - Calculate daily calorie balance', () {
      mealService.addMeal(
        user,
        today,
        'Breakfast',
        calories: 500,
      );

      final balance = summaryService.calorieBalance(
        user,
        today,
      );

      expect(balance, 2094);
    });

    test('S04 - Calculate weekly calories', () {
      mealService.addMeal(
        user,
        today,
        'Breakfast',
        calories: 500,
      );

      mealService.addMeal(
        user,
        DateTime(2026, 11, 19),
        'Lunch',
        calories: 700,
      );

      final total = summaryService.weeklyCaloriesEaten(
        user,
        today,
      );

      expect(total, 1200);
    });

    test('S05 - Check daily status below target', () {
      mealService.addMeal(
        user,
        today,
        'Breakfast',
        calories: 500,
      );

      expect(
        summaryService.getDayStatus(user, today),
        DayStatus.under,
      );
    });
  });
}
