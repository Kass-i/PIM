import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_and_shopping_list/db/ingredient.dart';
import 'package:recipe_and_shopping_list/providers/cart_provider.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  final Set<String> _checkedIngredients = {};

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider>(context);
    final recipes = provider.cart;

    final allIngredients = recipes.expand((r) => r.ingredients).toList();

    final Map<String, List<Ingredient>> grouped = {};
    for (final ingredient in allIngredients) {
      var tag = ingredient.tag ?? "No tag";
      grouped.putIfAbsent(tag, () => []);
      grouped[tag]!.add(ingredient);
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: grouped.entries.map((entry) {
                final tag = entry.key;
                final ingredients = entry.value;
                return Card(
                  color: Theme.of(context).colorScheme.secondaryContainer,
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
                        final key = "${ingredient.name}-${ingredient.tag}";
                        final isChecked = _checkedIngredients.contains(key);

                        return ListTile(
                          title: Text(
                            "${ingredient.name} (${ingredient.amount} ${ingredient.unit})",
                            style: TextStyle(
                              decoration: isChecked
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: isChecked ? Colors.grey : Colors.black,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              if (isChecked) {
                                _checkedIngredients.remove(key);
                              } else {
                                _checkedIngredients.add(key);
                              }
                            });
                          },
                        );
                      }),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          // Recipes
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...recipes.map((recipe) {
                  return ListTile(
                    title: Text(recipe.name),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          recipes.remove(recipe);
                        });
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
