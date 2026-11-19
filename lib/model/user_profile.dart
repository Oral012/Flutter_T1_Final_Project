enum Sex { male, female }

enum ActivityLevel {
  low(1.2),
  light(1.375),
  moderate(1.55),
  high(1.725);

  const ActivityLevel(this.value);

  final double value;
}

class UserProfile {
  final int age;
  final Sex sex;
  final double heightCm;
  final double weightKg;
  final ActivityLevel activityLevel;

  const UserProfile({
    required this.age,
    required this.sex,
    required this.heightCm,
    required this.weightKg,
    required this.activityLevel,
  });
}