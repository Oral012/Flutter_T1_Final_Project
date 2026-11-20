import 'package:flutter_test/flutter_test.dart';

import '../../lib/model/user.dart';
import '../../lib/service/meal_service.dart';

void main() {
  late User user;
  late MealService mealService;

  final today = DateTime(2026, 11, 20);

  setUp(() {
    user = User(name: 'Test User');
    mealService = MealService();
  });

  group('MealService Tests', () {
    test('M01 - Add a valid meal', () {
      final meal = mealService.addMeal(user, today, 'Breakfast', calories: 500);

      expect(meal.name, 'Breakfast');
      expect(meal.nutrition.calories, 500);
    });

    test('M02 - Reject empty meal name', () {
      expect(
        () => mealService.addMeal(user, today, '', calories: 500),
        throwsA(isA<Exception>()),
      );
    });

    test('M03 - Reject negative calories', () {
      expect(
        () => mealService.addMeal(user, today, 'Lunch', calories: -100),
        throwsA(isA<Exception>()),
      );
    });

    test('M04 - Calculate calories from nutrients', () {
      final meal = mealService.addMeal(
        user,
        today,
        'Chicken',
        protein: 20,
        carbs: 10,
        fat: 5,
      );

      // (20 * 4) + (10 * 4) + (5 * 9) = 165
      expect(meal.nutrition.calories, 165);
    });

    test('M05 - Edit existing meal', () {
      final meal = mealService.addMeal(user, today, 'Breakfast', calories: 300);

      mealService.editMeal(
        user,
        meal.id,
        name: 'Updated Breakfast',
        calories: 400,
      );

      expect(meal.name, 'Updated Breakfast');
      expect(meal.nutrition.calories, 400);
    });

    test('M06 - Delete existing meal', () {
      final meal = mealService.addMeal(user, today, 'Lunch', calories: 600);

      mealService.deleteMeal(user, meal.id);

      expect(mealService.getMealsForDate(user, today), isEmpty);
    });

    test('M07 - Reject deleting nonexistent meal', () {
      expect(
        () => mealService.deleteMeal(user, 999),
        throwsA(isA<Exception>()),
      );
    });
  });
}
