// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get main_appTitle => 'Recipe & Shopping List';

  @override
  String get main_widgetTitles => 'Recipes:Add new recipe:Shopping List';

  @override
  String get main_bottomNavBarRecipe => 'Recipes';

  @override
  String get main_bottomNavBarNewRecipe => 'New recipe';

  @override
  String get main_bottomNavBarCart => 'Cart';

  @override
  String get main_guest => 'Guest';

  @override
  String get main_login => 'Login';

  @override
  String get main_logout => 'Logout';

  @override
  String get main_darkMode => 'Dark mode';

  @override
  String get recipes_notInEditMode => 'The cart is not in the edit mode!';

  @override
  String get recipes_recipeAddedToCart => 'The recipe was added to the cart';

  @override
  String get recipes_areYouSure => 'Are you sure?';

  @override
  String get recipes_yes => 'Yes';

  @override
  String get recipes_no => 'No';

  @override
  String get recipes_noRecipes => 'No recipes';

  @override
  String get recipes_ingredients => 'Ingredients:';

  @override
  String get recipes_instructions => 'Instructions:';

  @override
  String get cart_noTag => 'No tag';

  @override
  String get cart_willUncheck =>
      'When you turn on edit mode, all ingredients will become unchecked.';

  @override
  String get cart_emptyCart => 'Empty cart';

  @override
  String get cart_editMode => 'Edit mode';

  @override
  String get cart_addedRecipes => 'Added recipes';

  @override
  String get newRecipe_units => 'pcs:g:dag:kg:ml:l:cup:tbsp:tsp';

  @override
  String get newRecipe_loginToAdd => 'Login to add the recipe!';

  @override
  String get newRecipe_addedSuccessfully => 'The recipe added successfully';

  @override
  String get newRecipe_wrongForm => 'Fill all recipe fields correctly';

  @override
  String get newRecipe_recipeName => 'Recipe name';

  @override
  String get newRecipe_ingredients => 'Ingredients';

  @override
  String get newRecipe_addIngredient => 'Add ingredient';

  @override
  String get newRecipe_recipe => 'Recipe';

  @override
  String get newRecipe_save => 'Save';

  @override
  String get ingredientRow_name => 'Name';

  @override
  String get ingredientRow_amount => 'Amount';

  @override
  String get ingredientRow_unit => 'Unit';

  @override
  String get ingredientRow_tag => 'Tag';
}
