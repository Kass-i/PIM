import 'package:flutter/material.dart';
import 'package:recipe_and_shopping_list/db/ingredient.dart';
import 'package:recipe_and_shopping_list/db/recipe.dart';

class RecipesProvider extends ChangeNotifier {
  final List<Recipe> _recipes = [
    Recipe(
      name: 'Naleśniki',
      directions:
          "1. Znajdź patelnię.\n2. Zrób naleśnika.\n3. Nie zabij się.\n4. Zjedz.",
      ingredients: [
        Ingredient(name: 'Mleko', amount: 200, unit: 'ml'),
        Ingredient(name: 'Jajka', amount: 1, unit: 'szt'),
        Ingredient(name: 'Mąka', amount: 1, unit: 'szklanka'),
      ],
    ),
    Recipe(
      name: 'Herbata',
      directions:
          "1. Zagotuj wodę.\n2. Wrzuć torebkę herbaty do kubka.\n3. Wlej wodę do kubka.\n4. Nie oparz się.\n5. Poczekaj z 2 min.",
      ingredients: [
        Ingredient(name: 'Torebka herbaty', amount: 1, unit: 'szt'),
        Ingredient(name: 'Woda', amount: 400, unit: 'ml'),
      ],
    ),
  ];

  List<Recipe> get recipes => _recipes;
}
