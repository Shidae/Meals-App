import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/categories_grid_item.dart';

import '../models/meal.dart';

class CategoriesScreen extends StatefulWidget {
  // animation operates on state which updates as long as it is playing
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

// merge a class which is needed by the animationController
// for multiple animation object use TickerProviderStateMixin
class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  // this variable will have a value as soon as it's being used the first time
  // but not yet when the class is created
  late AnimationController _animationController; // typr AnimationController

  @override
  void initState() {
    super.initState();
    // create an object of type AnimationController
    _animationController = AnimationController(
      // make the animation is executed on every frame
      vsync: this, // 60 times per second, frame rates= 60 frames
      duration: const Duration(milliseconds: 400),
      lowerBound: 0,
      upperBound: 1,
    );

    // forward() to start animation, repeat() etc.
    _animationController.forward();
  }

  @override
  void dispose() {
    // to save memory
    super.dispose();
    _animationController.dispose();
  }

  // pushing a new meals screen on top the category screen
  void _selectedCategory(BuildContext context, Category category) {
    // filter meals so that it's category matches the available category id
    // final filterCategory = dummyMeals
    final filterCategory = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filterCategory,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // the func in the builder executes for every frame
    // inside the function is widget to animate
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        // Scaffold and AppBar is removed because in TabsScreen, these are present
        padding: const EdgeInsets.all(14),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16),
        children: [
          // availableCategories.map( (category) => CategoriesGridItem(category:category)).toList()
          for (final category
              in availableCategories) // iterable can be taken from other packages
            CategoriesGridItem(
              category: category,
              onSelectCategory: () => _selectedCategory(context, category),
            ),
        ],
      ),
      // instead of animating (rebuild) the GridView (const) for every frame,
      // animate the padding to save runtime
      // set dynamic padding relative to the bound values
      builder: (context, child) => SlideTransition(
          position: Tween(begin: const Offset(0, 0.2), end: const Offset(0, 0))
              .animate(CurvedAnimation(
            // animate Tween coordinates
                  parent: _animationController, curve: Curves.bounceInOut)),
          child: child),
    );
  }
}

// SlideTransition(position: _animationController.drive(
// // x and y coordinates, translated from (0, 1)
// Tween(begin: const Offset(0, 0.2), end: const Offset(0, 0))),
// child: child),

// builder: (context, child) => Padding(
// // at 0sec, top padding: 0 pixel, after 200ms, top: 100 pixel, reverse
// padding: EdgeInsets.only(top: 100 - _animationController.value * 100),
// child: child,)

// alternative to Padding
// driver animates between the bound values (0, 1) to other values
