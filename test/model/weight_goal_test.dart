
import 'package:flutter_test/flutter_test.dart';
import 'package:nutrition_tracking/model/weight_goal.dart';

void main() {
  group('WeightGoal Model Tests', () {

    test('Should create lose weight goal', () {
      const goal = WeightGoal(
        type: GoalType.lose,
        targetWeightKg: 60,
        weeklyRateKg: 0.5,
      );

      expect(goal.type, GoalType.lose);
      expect(goal.targetWeightKg, 60);
      expect(goal.weeklyRateKg, 0.5);
    });

    test('Should create maintain weight goal', () {
      const goal = WeightGoal(
        type: GoalType.maintain,
      );

      expect(goal.type, GoalType.maintain);
      expect(goal.targetWeightKg, null);
      expect(goal.weeklyRateKg, null);
    });

    test('Should calculate maximum weekly weight change', () {
      expect(
        GoalType.lose.maxWeeklyRateKg(70),
        0.7,
      );

      expect(
        GoalType.gain.maxWeeklyRateKg(70),
        0.35,
      );

      expect(
        GoalType.maintain.maxWeeklyRateKg(70),
        0,
      );
    });

    test('Should return correct goal labels', () {
      expect(GoalType.lose.label, 'Lose weight');
      expect(GoalType.maintain.label, 'Maintain weight');
      expect(GoalType.gain.label, 'Gain weight');
    });
  });
}