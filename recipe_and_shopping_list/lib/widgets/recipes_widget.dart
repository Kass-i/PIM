import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_and_shopping_list/providers/recipes_provider.dart';

class RecipesWidget extends StatelessWidget {
  const RecipesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RecipesProvider>(context);
    final recipes = provider.recipes;

    return recipes.isEmpty
        ? const Center(child: Text("No recipes"))
        : ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                margin: const EdgeInsets.all(8),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ExpansionTile(
                  title: Text(
                    recipe.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                        const SizedBox(height: 8), // TODO: do it better
                        const Text(
                          'Directions:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(recipe.directions),
                        const SizedBox(height: 16), // TODO: do it better
                      ],
                    ),
                  ],
                ),
              );
            },
          );
  }
}
