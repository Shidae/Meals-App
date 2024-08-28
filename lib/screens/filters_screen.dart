import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/filters_provider.dart';

// import 'package:meals_app/screens/categories_screen.dart';
// import 'package:meals_app/screens/meals_screen.dart';
// import 'package:meals_app/screens/tabs_screen.dart';
// import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtered Options'),
      ),
      // drawer: MainDrawer( // drawer replaces the back button to navigate through other parts of the app
      //   onSelectScreen: (identifier) { // or define as a method
      //     Navigator.of(context).pop();
      //     if (identifier == "meals") {
      //       Navigator.of(context)
      //           .pushReplacement(MaterialPageRoute(builder: (ctx) => const TabsScreen()));
      //     }
      //   },
      // ),
      body: Column(
        children: [
          SwitchListTile(
            // needs a boolean on/off, a function that triggers the boolean, label of the switch
            value: activeFilters[Filter.glutenFree]!,
            // as managed state
            // func will receive whether the filter is checked in tabsScreen
            onChanged: (isChecked) {
              ref.read(filtersProvider.notifier).setFilter(
                  Filter.glutenFree, isChecked);
            },
            title: Text(
              "Gluten-free",
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme
                  .of(context)
                  .colorScheme
                  .onSurface),
            ),
            subtitle: Text(
              'Include only Gluten-free meals.',
              style: Theme
                  .of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Theme
                  .of(context)
                  .colorScheme
                  .onSurface),
            ),
            // color of the switch when it's on
            activeColor: Theme
                .of(context)
                .colorScheme
                .tertiary,
            // pad left of the title, right of the switch button
            contentPadding:
            const EdgeInsets.only(left: 50, right: 20), //adjust
          ),
          SwitchListTile(
            // needs a boolean on/off, a function that triggers the boolean, label of the switch
            value: activeFilters[Filter.lactoseFree]!,
            // as managed state
            // func will receive whether the filter is checked in tabsScreen
            onChanged: (isChecked) {
              ref.read(filtersProvider.notifier).setFilter(
                  Filter.lactoseFree, isChecked);
            },
            title: Text(
              "Lactose-free",
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme
                  .of(context)
                  .colorScheme
                  .onSurface),
            ),
            subtitle: Text(
              'Include only lactose-free meals.',
              style: Theme
                  .of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Theme
                  .of(context)
                  .colorScheme
                  .onSurface),
            ),
            // color of the switch when it's on
            activeColor: Theme
                .of(context)
                .colorScheme
                .tertiary,
            // pad left of the title, right of the switch button
            contentPadding:
            const EdgeInsets.only(left: 50, right: 20), //adjust
          ),
          SwitchListTile(
            // needs a boolean on/off, a function that triggers the boolean, label of the switch
            value: activeFilters[Filter.vegetarian]!,
            // as managed state
            // func will receive whether the filter is checked in tabsScreen
            onChanged: (isChecked) {
              ref.read(filtersProvider.notifier).setFilter(
                  Filter.vegetarian, isChecked);
            },
            title: Text(
              "Vegetarian",
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme
                  .of(context)
                  .colorScheme
                  .onSurface),
            ),
            subtitle: Text(
              'Include only vegetarian meals.',
              style: Theme
                  .of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Theme
                  .of(context)
                  .colorScheme
                  .onSurface),
            ),
            // color of the switch when it's on
            activeColor: Theme
                .of(context)
                .colorScheme
                .tertiary,
            // pad left of the title, right of the switch button
            contentPadding:
            const EdgeInsets.only(left: 50, right: 20), //adjust
          ),
          SwitchListTile(
            // needs a boolean on/off, a function that triggers the boolean, label of the switch
            value: activeFilters[Filter.vegan]!,
            // as managed state
            // func will receive whether the filter is checked in tabsScreen
            onChanged: (isChecked) {
              ref.read(filtersProvider.notifier).setFilter(
                  Filter.vegan, isChecked);
            },
            title: Text(
              "Vegan",
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme
                  .of(context)
                  .colorScheme
                  .onSurface),
            ),
            subtitle: Text(
              'Include only vegan meals.',
              style: Theme
                  .of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Theme
                  .of(context)
                  .colorScheme
                  .onSurface),
            ),
            // color of the switch when it's on
            activeColor: Theme
                .of(context)
                .colorScheme
                .tertiary,
            // pad left of the title, right of the switch button
            contentPadding:
            const EdgeInsets.only(left: 50, right: 20), //adjust
          ),
        ],
      ),
    );
  }
}
