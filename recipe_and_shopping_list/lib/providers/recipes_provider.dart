import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_and_shopping_list/db/ingredient.dart';
import 'package:recipe_and_shopping_list/db/recipe.dart';

class RecipesProvider extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  User? _user;

  List<Recipe> _recipes = [];
  List<Recipe> get recipes => _recipes;

  void updateUser(User? user) {
    if (_user?.uid == user?.uid) return; // Sanity check
    _user = user;

    if (_user != null) {
      fetchRecipes();
    } else {
      _recipes = [];
    }
    notifyListeners();
  }

  Future<void> fetchRecipes() async {
    if (_user == null) return; // Sanity check vol 2

    final snapshot = await _firestore.collection(_user!.uid).get();

    _recipes = snapshot.docs.map((doc) {
      final data = doc.data();
      return Recipe(
        name: doc.id,
        directions: data['directions'] ?? '',
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
      );
    }).toList();

    notifyListeners();
  }

  Future<void> addRecipe(Recipe recipe) async {
    if (_user == null) return;

    await _firestore.collection(_user!.uid).doc(recipe.name).set({
      'directions': recipe.directions,
      'ingredients': recipe.ingredients.map((i) {
        return {
          'name': i.name,
          'amount': i.amount,
          'unit': i.unit,
          'tag': i.tag,
        };
      }).toList(),
    });

    fetchRecipes();
    notifyListeners();
  }
}
