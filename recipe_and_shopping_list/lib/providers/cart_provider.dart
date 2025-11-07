import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_and_shopping_list/db/recipe.dart';
import 'package:recipe_and_shopping_list/db/ingredient.dart';

class CartProvider extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  User? _user;

  List<String> _cartIds = [];
  List<Recipe> _cartRecipes = [];

  List<Recipe> get cart => List.unmodifiable(_cartRecipes);

  void updateUser(User? user) {
    _user = user;
    if (_user != null) {
      loadCart();
    } else {
      _cartIds = [];
      _cartRecipes = [];
    }
    notifyListeners();
  }

  Future<void> addToCart(String recipeId) async {
    if (!_cartIds.contains(recipeId)) {
      _cartIds.add(recipeId);
      await _saveCartToPrefs();
      await _fetchCartRecipes();
      notifyListeners();
    }
  }

  Future<void> removeFromCart(String recipeId) async {
    _cartIds.remove(recipeId);
    await _saveCartToPrefs();
    await _fetchCartRecipes();
    notifyListeners();
  }

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    _cartIds = prefs.getStringList('cart_ids_${_user?.uid}') ?? [];
    await _fetchCartRecipes();
  }

  Future<void> _saveCartToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('cart_ids_${_user?.uid}', _cartIds);
  }

  Future<void> _fetchCartRecipes() async {
    if (_user == null) return;

    final List<Recipe> updatedCart = [];

    for (final id in _cartIds) {
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
        _cartIds.remove(id);
        await _saveCartToPrefs();
      }
    }

    _cartRecipes = updatedCart;
    notifyListeners();
  }
}
