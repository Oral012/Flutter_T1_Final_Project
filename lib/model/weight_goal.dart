enum GoalType {
  lose('Lose weight', maxPercent: 1.0),
  maintain('Maintain weight', maxPercent: 0),
  gain('Gain weight', maxPercent: 0.5);

  final String label;
  final double maxPercent; 

  const GoalType(this.label, {required this.maxPercent});

  double maxWeeklyRateKg(double weightKg) => weightKg * maxPercent / 100;
}


class WeightGoal {
  final GoalType type;
  final double? targetWeightKg; 
  final double? weeklyRateKg; 

  const WeightGoal({
    required this.type,
    this.targetWeightKg,
    this.weeklyRateKg,
  });
}