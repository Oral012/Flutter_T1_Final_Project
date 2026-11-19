class Nutrition {
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final double fiber;

  const Nutrition({
    required this.calories,
    this.protein = 0,
    this.carbs = 0,
    this.fat = 0,
    this.fiber = 0,
  });
}