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

  Set<String> _checkedIngredients = {};
  bool _isEditMode = true;

  List<Recipe> get cart => List.unmodifiable(_cartRecipes);
  Set<String> get checkedIngredients => _checkedIngredients;
  bool get isEditMode => _isEditMode;

  int getQuantity(String recipeId) => _cartQuantities[recipeId] ?? 0;

  void updateUser(User? user) {
    _user = user;
    if (_user != null) {
      loadCart();
      loadSettings();
    } else {
      _cartQuantities = {};
      _cartRecipes = [];
      _checkedIngredients.clear();
      _isEditMode = true;
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
                    amount: i['amount'] * _cartQuantities[id],
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

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final checkedJson = prefs.getString('checked_ingredients_${_user?.uid}');
    if (checkedJson != null) {
      _checkedIngredients = (jsonDecode(checkedJson) as List<dynamic>)
          .cast<String>()
          .toSet();
    } else {
      _checkedIngredients = {};
    }

    _isEditMode = prefs.getBool('is_edit_mode_${_user?.uid}') ?? true;
    notifyListeners();
  }

  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'checked_ingredients_${_user?.uid}',
      jsonEncode(_checkedIngredients.toList()),
    );
    await prefs.setBool('is_edit_mode_${_user?.uid}', _isEditMode);
  }

  void toggleEditMode(bool value) {
    _isEditMode = value;
    if (_isEditMode) {
      _checkedIngredients.clear();
    }
    saveSettings();
    notifyListeners();
  }

  void toggleIngredientChecked(String key) {
    if (_checkedIngredients.contains(key)) {
      _checkedIngredients.remove(key);
    } else {
      _checkedIngredients.add(key);
    }
    saveSettings();
    notifyListeners();
  }
}
