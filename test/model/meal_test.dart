
import 'package:flutter_test/flutter_test.dart';
import 'package:nutrition_tracking/model/meal.dart';
import 'package:nutrition_tracking/model/nutrition.dart';

void main() {
  group('Meal Model Tests', () {

    test('Should create a meal correctly', () {
      final date = DateTime(2026, 11, 22);

      final meal = Meal(
        id: 1,
        name: 'Chicken Rice',
        nutrition: const Nutrition(
          calories: 450,
          protein: 30,
          carbs: 50,
          fat: 12,
        ),
        loggedAt: date,
      );

      expect(meal.id, 1);
      expect(meal.name, 'Chicken Rice');
      expect(meal.nutrition.calories, 450);
      expect(meal.loggedAt, date);
    });

    test('Should update meal name', () {
      final meal = Meal(
        id: 2,
        name: 'Rice',
        nutrition: const Nutrition(calories: 200),
        loggedAt: DateTime(2026, 11, 22),
      );

      meal.name = 'Chicken Rice';

      expect(meal.name, 'Chicken Rice');
    });

    test('Should update meal nutrition', () {
      final meal = Meal(
        id: 3,
        name: 'Rice',
        nutrition: const Nutrition(calories: 200),
        loggedAt: DateTime(2026, 11, 22),
      );

      meal.nutrition = const Nutrition(calories: 500);

      expect(meal.nutrition.calories, 500);
    });
  });
}