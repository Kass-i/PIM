import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_and_shopping_list/db/ingredient.dart';
import 'package:recipe_and_shopping_list/providers/cart_provider.dart';

class ShoppingListPage extends StatelessWidget {
  const ShoppingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final recipes = cartProvider.cart;
    final isEditMode = cartProvider.isEditMode;

    final allIngredients = recipes.expand((r) => r.ingredients).toList();

    final Map<String, List<Ingredient>> grouped = {};
    for (final ingredient in allIngredients) {
      final tag = ingredient.tag ?? "No tag";
      grouped.putIfAbsent(tag, () => []);

      // Look for an existing ingredient with the same name and unit
      final existing = grouped[tag]!.firstWhere(
        (i) =>
            i.name.toLowerCase() == ingredient.name.toLowerCase() &&
            i.unit.toLowerCase() == ingredient.unit.toLowerCase(),
        orElse: () => Ingredient(name: '', amount: 0, unit: '', tag: tag),
      );

      // Ingredient with the same name and unit was not found - add as new ingredient
      if (existing.name.isEmpty) {
        grouped[tag]!.add(ingredient);
      } else {
        // Ingredient with the same name and unit was found - add amounts
        final updated = Ingredient(
          name: existing.name,
          amount: existing.amount! + ingredient.amount!,
          unit: existing.unit,
          tag: existing.tag,
        );

        final idx = grouped[tag]!.indexOf(existing);
        grouped[tag]![idx] = updated;
      }
    }

    void toggleEditMode(bool isEditMode) {
      if (!isEditMode) {
        cartProvider.toggleEditMode(isEditMode);
        return;
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Are you sure?"),
          content: const Text(
            "When you turn on edit mode, all ingredients will become unchecked.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                cartProvider.toggleEditMode(isEditMode);
                Navigator.pop(context);
              },
              child: const Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("No"),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: recipes.isEmpty
          ? const Center(child: Text("Empty cart"))
          : SingleChildScrollView(
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Edit mode'),
                    secondary: const Icon(Icons.edit_outlined),
                    value: isEditMode,
                    onChanged: toggleEditMode,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: grouped.length,
                    itemBuilder: (context, index) {
                      final entry = grouped.entries.elementAt(index);
                      final tag = entry.key;
                      final ingredients = entry.value;

                      return Card(
                        margin: const EdgeInsets.all(12),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              tag,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const Divider(),
                            ...ingredients.map((ingredient) {
                              final key =
                                  "${ingredient.name}-${ingredient.tag}-${ingredient.unit}";
                              final isChecked = cartProvider.checkedIngredients
                                  .contains(key);

                              return ListTile(
                                title: Text(
                                  "${ingredient.name} (${ingredient.amount} ${ingredient.unit})",
                                  style: TextStyle(
                                    decoration: isChecked
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    color: isChecked
                                        ? Colors.grey
                                        : Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.color,
                                  ),
                                ),
                                onTap: isEditMode
                                    ? null // Cannot check
                                    : () => cartProvider
                                          .toggleIngredientChecked(key),
                              );
                            }),
                          ],
                        ),
                      );
                    },
                  ),

                  // Recipes
                  if (isEditMode)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(14),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Added recipes",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...recipes.map((recipe) {
                            final quantity = cartProvider.getQuantity(
                              recipe.name,
                            );

                            return ListTile(
                              title: Text(recipe.name),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () => cartProvider
                                        .removeOneFromCart(recipe.name),
                                  ),
                                  Text('$quantity'),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () =>
                                        cartProvider.addToCart(recipe.name),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () => cartProvider
                                        .removeRecipeCompletely(recipe.name),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
