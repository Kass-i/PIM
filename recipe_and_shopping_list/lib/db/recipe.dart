import 'package:recipe_and_shopping_list/db/ingredient.dart';

class Recipe {
  Recipe({
    this.id,
    required this.name,
    required this.directions,
    required this.ingredients,
  });
  String? id;
  String name;
  String directions;
  List<Ingredient> ingredients;
}
