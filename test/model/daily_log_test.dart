
import 'package:flutter_test/flutter_test.dart';
import 'package:nutrition_tracking/model/daily_log.dart';
import 'package:nutrition_tracking/model/meal.dart';
import 'package:nutrition_tracking/model/nutrition.dart';

void main() {
  group('DailyLog Model Tests', () {

    test('Should create daily log with correct date', () {
      final log = DailyLog(DateTime(2026, 11, 22, 15, 30));

      expect(log.date.year, 2026);
      expect(log.date.month, 11);
      expect(log.date.day, 22);

      // Time should be reset to midnight.
      expect(log.date.hour, 0);
    });

    test('Should identify the same date', () {
      final log = DailyLog(DateTime(2026, 11, 22));

      expect(
        log.isSameDay(DateTime(2026, 11, 22, 18, 30)),
        true,
      );
    });

    test('Should identify different dates', () {
      final log = DailyLog(DateTime(2026, 11, 22));

      expect(
        log.isSameDay(DateTime(2026, 11, 23)),
        false,
      );
    });

    test('Should add a meal to daily log', () {
      final log = DailyLog(DateTime(2026, 11, 22));

      final meal = Meal(
        id: 1,
        name: 'Breakfast',
        nutrition: const Nutrition(calories: 300),
        loggedAt: DateTime(2026, 11, 22),
      );

      log.meals.add(meal);

      expect(log.meals.length, 1);
      expect(log.meals.first.name, 'Breakfast');
    });
  });
}