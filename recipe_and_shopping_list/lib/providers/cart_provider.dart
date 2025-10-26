import 'package:flutter/material.dart';
import 'package:recipe_and_shopping_list/db/ingredient.dart';
import 'package:recipe_and_shopping_list/db/recipe.dart';

class CartProvider extends ChangeNotifier {
  final List<Recipe> _cart = [
    Recipe(
      name: 'Naleśniki',
      directions:
          "1. Znajdź patelnię.\n2. Zrób naleśnika.\n3. Nie zabij się.\n4. Zjedz.",
      ingredients: [
        Ingredient(name: 'Mleko', amount: 200, unit: 'ml', tag: 'Biedronka'),
        Ingredient(name: 'Jajka', amount: 1, unit: 'szt', tag: 'Targ'),
        Ingredient(name: 'Mąka', amount: 1, unit: 'szklanka', tag: 'Biedronka'),
      ],
    ),
    Recipe(
      name: 'Herbata',
      directions:
          "1. Zagotuj wodę.\n2. Wrzuć torebkę herbaty do kubka.\n3. Wlej wodę do kubka.\n4. Nie oparz się.\n5. Poczekaj z 2 min.",
      ingredients: [
        Ingredient(name: 'Torebka herbaty', amount: 1, unit: 'szt', tag: 'Herbaciarnia'),
        Ingredient(name: 'Woda', amount: 400, unit: 'ml'),
      ],
    ),
  ];

  List<Recipe> get cart => _cart;
}
