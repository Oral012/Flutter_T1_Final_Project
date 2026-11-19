import 'nutrition.dart';

class Meal {
  final int id;
  String name; 
  Nutrition nutrition; 
  final DateTime loggedAt;

  Meal({
    required this.id,
    required this.name,
    required this.nutrition,
    required this.loggedAt,
  });
}