// display category items on the categories screen

import 'package:flutter/material.dart';
import '../models/category.dart'; // because this file is not directly in the lib folder

class CategoriesGridItem extends StatelessWidget {
  const CategoriesGridItem(
      {super.key, required this.category, required this.onSelectCategory});

  final Category category; // category is own name
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectCategory,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.9),
              category.color.withOpacity(0.6)
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context)
              .textTheme
              .titleLarge! // in main we did not specifically specify titleMedium but generally to all textTheme
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
    );
  }
}
