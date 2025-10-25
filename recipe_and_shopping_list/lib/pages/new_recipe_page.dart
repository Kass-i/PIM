import 'package:flutter/material.dart';
import 'package:recipe_and_shopping_list/db/ingredient.dart';
import 'package:recipe_and_shopping_list/widgets/ingredient_row.dart';

class NewRecipePage extends StatefulWidget {
  const NewRecipePage({super.key});

  @override
  State<NewRecipePage> createState() => _NewRecipePageState();
}

class _NewRecipePageState extends State<NewRecipePage> {
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<Ingredient> ingredients = [
    Ingredient(name: '', amount: null, unit: 'szt'),
  ];

  final List<String> units = [
    "szt",
    "g",
    "dag",
    "kg",
    "szkl.",
    "łyż.",
    "łyżecz.",
  ];

  void _addIngredient() {
    setState(() {
      ingredients.add(Ingredient(name: '', amount: null, unit: 'szt'));
    });
  }

  void _removeIngredient(int index) {
    setState(() {
      ingredients.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Add new recipe'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _recipeNameController,
              decoration: InputDecoration(
                labelText: "Recipe name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Ingredients",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            ...ingredients.asMap().entries.map((entry) {
              final index = entry.key;
              final ingredient = entry.value;

              return IngredientRow(
                ingredient: ingredient,
                units: units,
                onDelete: () => _removeIngredient(index),
                onNameChanged: (val) => ingredient.name = val,
                onAmountChanged: (val) => ingredient.amount = val as int,
                onUnitChanged: (val) => ingredient.unit = val,
                onTagChanged: (val) => ingredient.tag = val,
              );
            }),

            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text("Add ingredient"),
                onPressed: _addIngredient,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(160, 40),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: "Recipe",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: null,
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text("Save"),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(160, 40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
