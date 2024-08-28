// initialize keys of type Filter, which values are the state values (e.g. var _glutenFreeFilter = false defined in the state)
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/favourite_meals_provider.dart';
import 'package:meals_app/provider/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier() : super({
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  }); // initialize state as map type

  // define a method to overwrite state with choseFilters
  void setFilters(Map<Filter, bool> chosenFilters) {
    // expect a new map to overwrite the existing state
    state = chosenFilters;
  }
// method to update the state
  void setFilter(Filter filter, bool isActive) {
    // state[filter] = isActive; // is not allowed => mutating state
    // the state is the old map with the updated bool key
    state = {
      ...state, // old state
      filter: isActive, // updated state
    };


  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>((ref) {
  return FiltersNotifier();
});

// filteredMealsProvider is dependant on filtersProvider and mealsProvider
// similar providers can be stored in one file
// just Provider() since new notifier class is not created
final filteredMealsProvider = Provider((ref) {
  // the return will be executed is the data in provider changes
  // in return, other widget that listens to this provider would also change
  final meals = ref.watch(mealsProvider);
  // access filter date from the provider, not the method
  final activeFilters = ref.watch(filtersProvider);


  return meals.where((meal) {
    // if the filter is on and the meal does not represent it, return false,
    // otherwise true after all filters are applied
    if (!meal.isGlutenFree && activeFilters[Filter.glutenFree]!) {
      return false;
    }
    if (!meal.isLactoseFree && activeFilters[Filter.lactoseFree]!) {
      return false;
    }
    if (!meal.isVegetarian && activeFilters[Filter.vegetarian]!) {
      return false;
    }
    if (!meal.isVegan && activeFilters[Filter.vegan]!) {
      return false;
    }
    return true;
  }).toList();
});
