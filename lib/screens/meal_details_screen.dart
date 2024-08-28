import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/provider/favourite_meals_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({super.key, required this.meal});

  final Meal meal;

  @override
  // for Stateless Widget, ref is not globally defined
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteMeals = ref.watch(favouriteMealsProvider); // list of meals
    final isFavourite = favouriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              onPressed: () {
                // read once from the provider notifier
                // notifier gives access to the FavouriteMealsNotifier class
                // which contains the method
                final wasAdded = ref
                    .read(favouriteMealsProvider.notifier)
                    .toggleMealFavouriteStatus(meal);
                ScaffoldMessenger.of(context)
                    .clearSnackBars(); // context is always available in Stateful widget class
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(wasAdded
                        ? "Meal added as favourite"
                        : "Meal remove from favourite"))); // default duration is 4 seconds
              }, // when favourite icon is pressed, tab screen state is changed
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) { // child and animation are built-in, can be renamed
                  return ScaleTransition(scale: animation, child: child,);
                },
                // key is needed for the same type (Icon) but different widget
                child: Icon(isFavourite ? Icons.star : Icons.star_border, key: ValueKey(isFavourite) ,),
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Hero(
                  tag: meal.id,
                  child: Image.network(
                    meal.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Ingredients",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
                const SizedBox(
                  height: 20,
                ),
                for (final ingredient in meal.ingredients)
                  Text(
                    ingredient,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "Steps",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
                for (final step in meal.steps)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    child: Text(
                      step,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
