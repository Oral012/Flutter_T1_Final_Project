import '../model/nutrition.dart';
import '../model/user.dart';
import 'goal_service.dart';
import '../model/weight_goal.dart';


enum DayStatus { under, onTarget, over }
class SummaryService {
  final GoalService _goalService = GoalService();

  Nutrition totalNutrition(User user, DateTime date) {
    double calories = 0, protein = 0, carbs = 0, fat = 0, fiber = 0;
    for (final log in user.logs) {
      if (!log.isSameDay(date)) continue;
      for (final meal in log.meals) {
        calories += meal.nutrition.calories;
        protein += meal.nutrition.protein;
        carbs += meal.nutrition.carbs;
        fat += meal.nutrition.fat;
        fiber += meal.nutrition.fiber;
      }
    }
    return Nutrition(
      calories: calories,
      protein: protein,
      carbs: carbs,
      fat: fat,
      fiber: fiber,
    );
  }

  int dailyTarget(User user) {
    if (user.profile == null) throw Exception('Create a profile first');
    return _goalService.calculateDailyTarget(user.profile!, user.weightGoal);
  }

  int calorieBalance(User user, DateTime date) {
    final eaten = totalNutrition(user, date).calories.round();
    return dailyTarget(user) - eaten;
  }

  /// Under / on target / over. On target = within 10% of the target.
  DayStatus getDayStatus(User user, DateTime date) {
    final target = dailyTarget(user);
    final eaten = totalNutrition(user, date).calories;

    if (eaten * 10 < target * 9) return DayStatus.under;
    if (eaten * 10 > target * 11) return DayStatus.over;
    return DayStatus.onTarget;
  }

 
  bool hasWarning(User user, DateTime date) {
    final status = getDayStatus(user, date);
    return switch (user.weightGoal.type) {
      GoalType.lose => status == DayStatus.over,
      GoalType.gain => status == DayStatus.under,
      GoalType.maintain => status != DayStatus.onTarget,
    };
  }


  int weeklyTarget(User user) => dailyTarget(user) * 7;

  double weeklyCaloriesEaten(User user, DateTime date) {
    final monday =
        DateTime(date.year, date.month, date.day - (date.weekday - 1));
    final nextMonday = DateTime(monday.year, monday.month, monday.day + 7);

    double total = 0;
    for (final log in user.logs) {
      if (!log.date.isBefore(monday) && log.date.isBefore(nextMonday)) {
        for (final meal in log.meals) {
          total += meal.nutrition.calories;
        }
      }
    }
    return total;
  }

  int weeklyBalance(User user, DateTime date) {
    return weeklyTarget(user) - weeklyCaloriesEaten(user, date).round();
  }
}