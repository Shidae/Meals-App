import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/provider/favourite_meals_provider.dart';
import 'package:meals_app/provider/filters_provider.dart';
import 'package:meals_app/provider/meals_provider.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';
// import '../models/meal.dart';

// initialize a default setting for the switch and fallback value
const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

// this is the most upper state of the app that manages states of screen
// does not take any inputs other than key
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _Tabs();
  }
}

class _Tabs extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

// for onSelectScreen(String) of the mainDrawer
  void _selectDrawerScreen(String identifier) async {
    Navigator.of(context)
        .pop(); // close the drawer anyway once any item is clicked
    if (identifier == 'filters') {
      // navigate to the filtersScreen
      // wait until user selects the filtersScreen
      // push is a generic type
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
    else { // since two choices are available, else without condition suffices
      Navigator.of(context).pushReplacement( // replace the backbutton
        MaterialPageRoute(
          builder: (ctx) => const TabsScreen()),
        );
    } // Navigate to the current tabScreen if other identifier is selected
  }

  @override
  Widget build(BuildContext context) {
    // to filter the filtered meals to CategoriesScreen
    // second filter provide
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    ); // used as the Scaffold body

    Widget activePageTitle = // categories screen
    const Text("What's cookin'?"); // used as the AppBar title

    if (_selectedPageIndex == 1) { // favourite screen
      final favouriteMeals = ref.watch(favouriteMealsProvider);
      // when Favourite tab is tapped, display the MealsScreen
      activePage = MealsScreen(
        meals: favouriteMeals,
        title: '',
      );
      activePageTitle = const Text("Favourited Meals");
    }

    return Scaffold(
      appBar: AppBar(
        title: activePageTitle,
      ),
      drawer: MainDrawer(
        onSelectScreen: _selectDrawerScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        // a function that accepts the tab index which is tapped
        currentIndex: _selectedPageIndex,
        // to highlight which tab is tapped
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favourites")
        ],
      ),
    );
  }
}
