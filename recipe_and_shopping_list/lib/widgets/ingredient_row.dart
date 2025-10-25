import 'package:flutter/material.dart';
import 'package:recipe_and_shopping_list/db/ingredient.dart';

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
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Ingredient name, delete icon
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: onNameChanged,
                    controller: TextEditingController(text: ingredient.name),
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
                    decoration: const InputDecoration(
                      labelText: "Amount",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: onAmountChanged,
                    controller: TextEditingController(
                      text: ingredient.amount?.toString(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 4,
                  child: DropdownButtonFormField<String>(
                    initialValue: ingredient.unit,
                    decoration: const InputDecoration(
                      labelText: "Unit",
                      border: OutlineInputBorder(),
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
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Tag",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      filled: true,
                      fillColor: Theme.of(
                        context,
                      ).colorScheme.secondaryContainer,
                    ),
                    onChanged: onTagChanged,
                    controller: TextEditingController(text: ingredient.tag),
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
