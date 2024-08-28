// Provider class for data that can change
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  // constructor function of same name to the class
  // super to forward to parent class StateNotifier
  // pass initial data to the super, of type List
  FavouriteMealsNotifier() : super([]);

  // add method to edit the data
  // however using StateNotifier, it's not allowed to edit the existing list []
  // e.g. add() or remove(). reassign is allowed e.g. where() => true to keep,
  // filter the favouriteMeals before reassigning [] to a new list

  bool toggleMealFavouriteStatus(Meal meal) {
    // meal that is being toggled
    // state here is the _favouriteMeals list
    // mealsFavourite here is the isExisting bool
    final mealIsFavourite = state.contains(meal);

    if (mealIsFavourite) {
      // m is the temporary variable used in where() function,
      // m is each meal in the state list
      // if mealIsFavourite (true), state list removes the meal from it
      // unmarked as favourite
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      // if the meal is not in the list (false), mark as favourite
      // keep the existing favourite meal and add new ones into a new []
      // spread operator (...) to pull out all the elements of existing list,
      // add them to a new list, and add new elements (meal)
      state = [...state, meal];
      return true;
    }
  }
}

final favouriteMealsProvider =
    StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>((ref) {
  return FavouriteMealsNotifier();
});
