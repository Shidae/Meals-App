import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});

  final Meal meal;

  // each meal item requires onTap function but not push to the next screen
  final void Function(Meal meal) onSelectMeal;


  // Capitalize the enum Widgets
  String capitalize(String string) {
    return string[0].toUpperCase() + string.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.hardEdge,
      // content that goes out of the circular shape is cut off
      elevation: 10,
      // size of the shadow
      child: InkWell(
        // the stack should be clickable
        onTap: () {onSelectMeal(meal);},
        child: Stack(
          children: [
            // order: low to top level stack
            // animate object across different screens
            Hero(
              tag: meal.id, // unique per meal, also tag at the target screen
              child: FadeInImage(
                // image fades in once it is available
                // transparent image before the actual image appears
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),

            Positioned(
              // does not require Expanded() because the Text is
              // forced to take the width of the stack using the right, left=0 arguments.
              // here is how the child container start relative to the image
              bottom: 0,
              // top: 0, // not glued to the top position
              right: 0,
              left: 0,
              child: Container(
                color: Colors.black54,
                // slight transparent background to the text
                padding: // padding of text
                    const EdgeInsets.symmetric(vertical: 3, horizontal: 40),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      // first row title, second metadata
                      textAlign: TextAlign.center,
                      softWrap: true,
                      // try true
                      overflow: TextOverflow.ellipsis,
                      // overflowed text cut off ...
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      // below the text box
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // meta data
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        MealItemTrait(
                          icon: Icons.extension,
                          label: capitalize(meal.complexity.name),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        MealItemTrait(
                          icon: Icons.attach_money_outlined,
                          label: capitalize(meal.affordability.name),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
