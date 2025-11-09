import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_and_shopping_list/db/ingredient.dart';
import 'package:recipe_and_shopping_list/providers/recipes_provider.dart';
import 'package:recipe_and_shopping_list/widgets/autocomplete_filed.dart';

class IngredientRow extends StatelessWidget {
  final Ingredient ingredient;
  final List<String> units;
  final VoidCallback onDelete;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<String> onAmountChanged;
  final ValueChanged<String> onUnitChanged;
  final ValueChanged<String> onTagChanged;

  const IngredientRow({
    super.key,
    required this.ingredient,
    required this.units,
    required this.onDelete,
    required this.onNameChanged,
    required this.onAmountChanged,
    required this.onUnitChanged,
    required this.onTagChanged,
  });

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipesProvider>(context);
    final tags = recipeProvider.allTags;
    final ingredients = recipeProvider.allIngredientNames;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Ingredient name, delete icon
            Row(
              children: [
                Expanded(
                  child: AutocompleteField(
                    availableOptions: ingredients,
                    onChanged: onNameChanged,
                    inputDecoration: InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
              ],
            ),
            const SizedBox(height: 10),

            // Amount, unit, tag
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Amount",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: onAmountChanged,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 4,
                  child: DropdownButtonFormField<String>(
                    initialValue: ingredient.unit,
                    decoration: InputDecoration(
                      labelText: "Unit",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    items: units
                        .map(
                          (unit) =>
                              DropdownMenuItem(value: unit, child: Text(unit)),
                        )
                        .toList(),
                    onChanged: (val) => onUnitChanged(val!),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 6,
                  child: AutocompleteField(
                    availableOptions: tags,
                    onChanged: onTagChanged,
                    inputDecoration: InputDecoration(
                      labelText: "Tag",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.primaryContainer,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
