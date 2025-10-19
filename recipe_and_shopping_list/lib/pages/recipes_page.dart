import 'package:flutter/material.dart';
import 'package:recipe_and_shopping_list/widgets/recipes_widget.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Recipes'),
      ),
      body: RecipesWidget(),
    );
  }
}
