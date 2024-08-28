import 'package:flutter/material.dart';
import 'package:meals_app/main.dart';
import 'package:meals_app/screens/meal_details_screen.dart';
import 'package:meals_app/widgets/meal_item.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
      {super.key,
      required this.title,
      required this.meals,});

  // final Category category;
  final String?
      title; // make input optional because TabsScreen already specifies it
  final List<Meal> meals; // import the model meal

  void _selectedMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      // in the current screen, push to the next screen
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // create a default content widget if the meals are empty
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "There's nothing here.",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Select a different category.",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(
          meal: meals[index],
          onSelectMeal: (meal) {
            // in MeanItem, function requires argument meal
            _selectedMeal(context, meal);
          },
        ),
      );
    }

    if (title == null) {
      // if no title is given, return the content without the title
      return content;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(title!), // if title is given
        ),
        body: content);
  }
}
