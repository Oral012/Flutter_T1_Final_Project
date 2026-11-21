
import 'package:flutter_test/flutter_test.dart';
import 'package:nutrition_tracking/model/nutrition.dart';

void main() {
  group('Nutrition Model Tests', () {

    test('Should create Nutrition with all values', () {
      const nutrition = Nutrition(
        calories: 500,
        protein: 20,
        carbs: 60,
        fat: 10,
        fiber: 5,
      );

      expect(nutrition.calories, 500);
      expect(nutrition.protein, 20);
      expect(nutrition.carbs, 60);
      expect(nutrition.fat, 10);
      expect(nutrition.fiber, 5);
    });

    test('Should use default nutrient values as zero', () {
      const nutrition = Nutrition(calories: 300);

      expect(nutrition.calories, 300);
      expect(nutrition.protein, 0);
      expect(nutrition.carbs, 0);
      expect(nutrition.fat, 0);
      expect(nutrition.fiber, 0);
    });

    test('Should accept zero calories', () {
      const nutrition = Nutrition(calories: 0);

      expect(nutrition.calories, 0);
    });
  });
}