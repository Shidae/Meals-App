import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealItemTrait extends StatelessWidget {
  const MealItemTrait({super.key, required this.icon, required this.label});

  final IconData icon; // IconData is flutter Type
  final String label; // label shown next to the icon

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // continue row widget from the meals_screen
        Icon(
          icon,
          size: 16,
          color: Colors.white,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
