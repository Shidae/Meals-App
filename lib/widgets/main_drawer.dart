import 'package:flutter/material.dart';
 // here is the burger side bar configs are
class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final void Function(String identifier) onSelectScreen;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.onPrimary,
                Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
              ], begin: Alignment.center, end: Alignment.bottomCenter),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.fastfood_outlined,
                  size: 30,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  "Cookin' App",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.restaurant_menu,
              size: 20,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            title: Text(
              "All Meals",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface),
            ),
            onTap: () {onSelectScreen('meals');},
          ),ListTile(
            leading: Icon(
              Icons.settings,
              size: 20,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            title: Text(
              "Filter",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface),
            ),
            onTap: () {
            // Navigator.of(context).push;
            onSelectScreen('filters'); // so tabScreen can use the string identifier to load specific screen
            },
          ),
        ],
      ),
    );
  }
}
