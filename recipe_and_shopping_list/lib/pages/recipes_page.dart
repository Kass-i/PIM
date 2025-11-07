import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_and_shopping_list/providers/recipes_provider.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipesProvider>(context);
    final recipes = recipeProvider.recipes;

    return Scaffold(
      body: recipes.isEmpty
          ? const Center(child: Text("No recipes"))
          : ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ExpansionTile(
                    expandedAlignment: Alignment.topLeft,
                    childrenPadding: EdgeInsets.symmetric(horizontal: 80),
                    title: Text(
                      recipe.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {},
                    ),
                    shape: Border(), // Remove divider lines
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ingredients:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          ...recipe.ingredients.map(
                            (ingredient) => Text(
                              '- ${ingredient.name} '
                              '(${ingredient.amount} ${ingredient.unit})',
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Directions:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(recipe.directions),
                          const SizedBox(height: 8),

                          // TODO: change it
                          Center(
                            child: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                recipeProvider.deleteRecipe(recipe.name);
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
