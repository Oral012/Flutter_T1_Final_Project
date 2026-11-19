import 'meal.dart';

class DailyLog {
  final DateTime date; 
  final List<Meal> meals = [];

  DailyLog(DateTime date) : date = DateTime(date.year, date.month, date.day);

  bool isSameDay(DateTime other) =>
      date.year == other.year &&
      date.month == other.month &&
      date.day == other.day;
}