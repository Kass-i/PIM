import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_and_shopping_list/db/ingredient.dart';
import 'package:recipe_and_shopping_list/db/recipe.dart';
import 'package:recipe_and_shopping_list/providers/recipes_provider.dart';
import 'package:recipe_and_shopping_list/widgets/ingredient_row.dart';

class NewRecipePage extends StatefulWidget {
  const NewRecipePage({super.key});

  @override
  State<NewRecipePage> createState() => _NewRecipePageState();
}

class _NewRecipePageState extends State<NewRecipePage> {
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final List<Ingredient> _ingredients = [
    Ingredient(name: '', amount: null, unit: 'szt'),
  ];

  final List<String> _units = [
    "szt",
    "g",
    "dag",
    "kg",
    "ml",
    "l",
    "szkl.",
    "łyż.",
    "łyżecz.",
  ];

  void _addIngredient() {
    setState(() {
      _ingredients.add(Ingredient(name: '', amount: null, unit: 'szt'));
    });
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredients.removeAt(index);
    });
  }

  bool _isCorrectRecipe() {
    if (_recipeNameController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _ingredients.isEmpty) {
      return false;
    }

    for (final ingredient in _ingredients) {
      if (ingredient.name.isEmpty ||
          ingredient.amount == null ||
          ingredient.unit.isEmpty) {
        return false;
      }
    }

    return true;
  }

  Recipe _createRecipe() {
    var recipe = Recipe(
      name: _recipeNameController.text,
      directions: _descriptionController.text,
      ingredients: _ingredients,
    );

    return recipe;
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipesProvider>(context);

    void saveRecipe() {
      String message;
      bool error = false;
      if (_isCorrectRecipe()) {
        recipeProvider.addRecipe(_createRecipe());
        if (recipeProvider.recipes.isEmpty) {
          message = "Login to add the recipe!";
          error = true;
        } else {
          message = "The recipe added successfully";
        }
      } else {
        message = "Fill all recipe fields correctly";
        error = true;
      }

      error
          ? ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  message,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onError,
                  ),
                ),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            )
          : ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
    }

    return Scaffold(
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

            ..._ingredients.asMap().entries.map((entry) {
              final index = entry.key;
              final ingredient = entry.value;

              return IngredientRow(
                ingredient: ingredient,
                units: _units,
                onDelete: () => _removeIngredient(index),
                onNameChanged: (val) => ingredient.name = val,
                onAmountChanged: (val) => ingredient.amount = int.tryParse(val),
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
                onPressed: () => saveRecipe(),
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
