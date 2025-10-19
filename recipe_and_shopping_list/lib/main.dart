import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_and_shopping_list/pages/recipes_page.dart';
import 'package:recipe_and_shopping_list/providers/recipes_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => RecipesProvider())],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe & Shopping List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: RecipesPage(),
    );
  }
}
