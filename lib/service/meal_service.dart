import '../model/daily_log.dart';
import '../model/meal.dart';
import '../model/nutrition.dart';
import '../model/user.dart';

class MealService {
  int _nextId = 1;


  Meal addMeal(
    User user,
    DateTime date,
    String name, {
    double? calories,
    double protein = 0,
    double carbs = 0,
    double fat = 0,
    double fiber = 0,
  }) {
    final nutrition = _validateNutrition(name, calories, protein, carbs, fat, fiber);

    final log = _findLog(user, date) ?? _createLog(user, date);
    final meal = Meal(
      id: _nextId++,
      name: name.trim(),
      nutrition: nutrition,
      loggedAt: date,
    );
    log.meals.add(meal);
    return meal;
  }

  Meal editMeal(
    User user,
    int mealId, {
    String? name,
    double? calories,
    double? protein,
    double? carbs,
    double? fat,
    double? fiber,
  }) {
    final meal = _findMeal(user, mealId);

    if (name != null && name.trim().isEmpty) {
      throw Exception('Meal name cannot be empty');
    }
    if (calories != null && (calories.isNaN || calories < 0) || 
        protein != null && protein < 0 || 
        carbs != null && carbs < 0 || 
        fat != null && fat < 0 || 
        fiber != null && fiber < 0) {
      throw Exception('Values cannot be negative');
    }

    final old = meal.nutrition;
    meal.nutrition = Nutrition(
      calories: calories ?? old.calories,
      protein: protein ?? old.protein,
      carbs: carbs ?? old.carbs,
      fat: fat ?? old.fat,
      fiber: fiber ?? old.fiber,
    );
    if (name != null) meal.name = name;
    return meal;
  }


  void deleteMeal(User user, int mealId) {
    for (final log in user.logs) {
      final index = log.meals.indexWhere((m) => m.id == mealId);
      if (index != -1) {
        log.meals.removeAt(index);
        return;
      }
    }
    throw Exception('Meal not found');
  }


  List<Meal> getMealsForDate(User user, DateTime date) {
    final log = _findLog(user, date);
    return log == null ? [] : log.meals;
  }

  Nutrition _validateNutrition(
    String name,
    double? calories,
    double protein,
    double carbs,
    double fat,
    double fiber,
  ) {
    if (name.trim().isEmpty) {
      throw Exception('Meal name cannot be empty');
    }
    if ((calories != null && (calories.isNaN || calories < 0)) ||protein < 0 ||carbs < 0 ||fat < 0 || fiber < 0) {
      throw Exception('Values cannot be negative');
    }
    if (calories == null && protein == 0 && carbs == 0 && fat == 0 &&  fiber == 0) {
      throw Exception('Enter calories or nutrients');
    }

    return Nutrition(
      calories: calories ?? (4 * protein + 4 * carbs + 9 * fat + 2 * fiber),
      protein: protein,
      carbs: carbs,
      fat: fat,
      fiber: fiber,
    );
  }

  DailyLog? _findLog(User user, DateTime date) {
    for (final log in user.logs) {
      if (log.isSameDay(date)) return log;
    }
    return null;
  }

  DailyLog _createLog(User user, DateTime date) {
    final log = DailyLog(date);
    user.logs.add(log);
    return log;
  }

  Meal _findMeal(User user, int mealId) {
    for (final log in user.logs) {
      for (final meal in log.meals) {
        if (meal.id == mealId) return meal;
      }
    }
    throw Exception('Meal not found');
  }
}