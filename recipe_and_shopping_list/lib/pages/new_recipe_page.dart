import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_and_shopping_list/db/ingredient.dart';
import 'package:recipe_and_shopping_list/db/recipe.dart';
import 'package:recipe_and_shopping_list/l10n/app_localizations.dart';
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

  final List<Ingredient> _ingredients = [];
  String _firstUnit = "";

  void _initIngredients(String firstUnit) {
    setState(() {
      _firstUnit = firstUnit;
      _ingredients.add(Ingredient(name: '', amount: null, unit: _firstUnit));
    });
  }

  void _addIngredient() {
    setState(() {
      _ingredients.add(Ingredient(name: '', amount: null, unit: _firstUnit));
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
    final trans = AppLocalizations.of(context)!;

    final recipeProvider = Provider.of<RecipesProvider>(context);

    final List<String> units = trans.newRecipe_units.split(':');
    _initIngredients(units[0]);

    void saveRecipe() {
      String message;
      bool error = false;
      if (_isCorrectRecipe()) {
        recipeProvider.addRecipe(_createRecipe());
        if (recipeProvider.recipes.isEmpty) {
          message = trans.newRecipe_loginToAdd;
          error = true;
        } else {
          message = trans.newRecipe_addedSuccessfully;
        }
      } else {
        message = trans.newRecipe_wrongForm;
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
                labelText: trans.newRecipe_recipeName,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              trans.newRecipe_ingredients,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            ..._ingredients.asMap().entries.map((entry) {
              final index = entry.key;
              final ingredient = entry.value;

              return IngredientRow(
                ingredient: ingredient,
                units: units,
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
                label: Text(trans.newRecipe_addIngredient),
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
                labelText: trans.newRecipe_recipe,
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
                label: Text(trans.newRecipe_save),
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
