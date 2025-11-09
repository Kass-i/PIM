import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_and_shopping_list/db/recipe.dart';
import 'package:recipe_and_shopping_list/db/ingredient.dart';

class CartProvider extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  User? _user;

  Map<String, int> _cartQuantities = {};
  List<Recipe> _cartRecipes = [];

  List<Recipe> get cart => List.unmodifiable(_cartRecipes);

  int getQuantity(String recipeId) => _cartQuantities[recipeId] ?? 0;

  void updateUser(User? user) {
    _user = user;
    if (_user != null) {
      loadCart();
    } else {
      _cartQuantities = {};
      _cartRecipes = [];
    }
    notifyListeners();
  }

  Future<void> addToCart(String recipeId) async {
    _cartQuantities[recipeId] = (_cartQuantities[recipeId] ?? 0) + 1;
    await _saveCartToPrefs();
    await _fetchCartRecipes();
    notifyListeners();
  }

  Future<void> removeOneFromCart(String recipeId) async {
    if (!_cartQuantities.containsKey(recipeId)) return;

    if (_cartQuantities[recipeId]! > 1) {
      _cartQuantities[recipeId] = _cartQuantities[recipeId]! - 1;
    } else {
      _cartQuantities.remove(recipeId);
    }

    await _saveCartToPrefs();
    await _fetchCartRecipes();
    notifyListeners();
  }

  Future<void> removeRecipeCompletely(String recipeId) async {
    _cartQuantities.remove(recipeId);
    await _saveCartToPrefs();
    await _fetchCartRecipes();
    notifyListeners();
  }

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('cart_data_${_user?.uid}');
    if (jsonString != null) {
      final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
      _cartQuantities = decoded.map(
        (key, value) => MapEntry(key, value as int),
      );
    } else {
      _cartQuantities = {};
    }
    await _fetchCartRecipes();
  }

  Future<void> _saveCartToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(_cartQuantities);
    await prefs.setString('cart_data_${_user?.uid}', jsonString);
    print("\n");
    print(prefs.getString('cart_data_${_user?.uid}'));
  }

  Future<void> _fetchCartRecipes() async {
    if (_user == null) return;

    final List<Recipe> updatedCart = [];

    for (final id in _cartQuantities.keys) {
      final doc = await _firestore.collection(_user!.uid).doc(id).get();
      if (doc.exists) {
        final data = doc.data()!;
        updatedCart.add(
          Recipe(
            name: id,
            directions: data['directions'],
            ingredients: (data['ingredients'] as List)
                .map(
                  (i) => Ingredient(
                    name: i['name'],
                    amount: i['amount'],
                    unit: i['unit'],
                    tag: i['tag'],
                  ),
                )
                .toList(),
          ),
        );
      } else {
        // The recipe has been removed from Firestore so remove it from the cart
        _cartQuantities.remove(id);
        await _saveCartToPrefs();
      }
    }

    _cartRecipes = updatedCart;
    notifyListeners();
  }
}
