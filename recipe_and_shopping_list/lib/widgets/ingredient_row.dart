import 'package:flutter/material.dart';
import 'package:recipe_and_shopping_list/db/ingredient.dart';

class IngredientRow extends StatelessWidget {
  final Ingredient ingredient;
  final List<String> units;
  final VoidCallback onDelete;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<String> onAmountChanged;
  final ValueChanged<String> onUnitChanged;

  const IngredientRow({
    super.key,
    required this.ingredient,
    required this.units,
    required this.onDelete,
    required this.onNameChanged,
    required this.onAmountChanged,
    required this.onUnitChanged,
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
            // Ingredient name
            TextField(
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
              onChanged: onNameChanged,
              controller: TextEditingController(text: ingredient.name),
            ),
            const SizedBox(height: 10),

            // Amount, unit, delete icon
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
                    controller: TextEditingController(text: ingredient.amount?.toString()),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 3,
                  child: DropdownButtonFormField<String>(
                    initialValue: ingredient.unit,
                    decoration: const InputDecoration(
                      labelText: "Unit",
                      border: OutlineInputBorder(),
                    ),
                    items: units
                        .map((unit) => DropdownMenuItem(
                              value: unit,
                              child: Text(unit),
                            ))
                        .toList(),
                    onChanged: (val) => onUnitChanged(val!),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}