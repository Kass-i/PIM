import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_and_shopping_list/l10n/app_localizations.dart';
import 'package:recipe_and_shopping_list/providers/cart_provider.dart';
import 'package:recipe_and_shopping_list/providers/recipes_provider.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final trans = AppLocalizations.of(context)!;

    final recipeProvider = Provider.of<RecipesProvider>(context);
    final recipes = recipeProvider.recipes;

    final cartProvider = Provider.of<CartProvider>(context);
    final isEditMode = cartProvider.isEditMode;

    void addToCart(String recipeName) {
      if (!isEditMode) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              trans.recipes_notInEditMode,
              style: TextStyle(color: Theme.of(context).colorScheme.onError),
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
        return;
      }

      cartProvider.addToCart(recipeName);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(trans.recipes_recipeAddedToCart)));
    }

    void deleteRecipe(String recipeName) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(trans.recipes_areYouSure),
          actions: [
            TextButton(
              onPressed: () {
                recipeProvider.deleteRecipe(recipeName);
                cartProvider.removeRecipeCompletely(recipeName);
                Navigator.pop(context);
              },
              child: Text(trans.recipes_yes),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(trans.recipes_no),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: recipes.isEmpty
          ? Center(child: Text(trans.recipes_noRecipes))
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
                      onPressed: () => addToCart(recipe.name),
                    ),
                    shape: Border(), // Remove divider lines
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            trans.recipes_ingredients,
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
                          Text(
                            trans.recipes_instructions,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(recipe.directions),
                          const SizedBox(height: 8),

                          Center(
                            child: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => deleteRecipe(recipe.name),
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
