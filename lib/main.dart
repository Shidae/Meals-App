import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';
// import 'package:meals_app/data/dummy_data.dart';
// import 'package:meals_app/screens/categories_screen.dart';
// import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),

  // valid for all fonts title large, medium, small
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      // home: const MealsScreen(title: "Sample title", meals: dummyMeals),
      home: const TabsScreen()

    );
  }
}
