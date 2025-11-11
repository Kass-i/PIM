// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get main_appTitle => 'Przepisy i Lista Zakupów';

  @override
  String get main_widgetTitles => 'Przepisy:Dodaj nowy przepis:Lista zakupów';

  @override
  String get main_bottomNavBarRecipe => 'Przepisy';

  @override
  String get main_bottomNavBarNewRecipe => 'Nowy przepis';

  @override
  String get main_bottomNavBarCart => 'Koszyk';

  @override
  String get main_guest => 'Gość';

  @override
  String get main_login => 'Zaloguj się';

  @override
  String get main_logout => 'Wyloguj się';

  @override
  String get main_darkMode => 'Tryb ciemny';

  @override
  String get main_language => 'Język';

  @override
  String get recipes_notInEditMode => 'Koszyk nie jest w trybie edycji!';

  @override
  String get recipes_recipeAddedToCart => 'Przepis został dodany do koszyka';

  @override
  String get recipes_areYouSure => 'Czy jesteś pewien?';

  @override
  String get recipes_yes => 'Tak';

  @override
  String get recipes_no => 'Nie';

  @override
  String get recipes_noRecipes => 'Brak przepisów';

  @override
  String get recipes_ingredients => 'Składniki:';

  @override
  String get recipes_instructions => 'Instrukcje:';

  @override
  String get cart_noTag => 'Brak tagu';

  @override
  String get cart_willUncheck =>
      'Po włączeniu trybu edycji wszystkie składniki zostaną odznaczone.';

  @override
  String get cart_emptyCart => 'Pusty koszyk';

  @override
  String get cart_editMode => 'Tryb edycji';

  @override
  String get cart_addedRecipes => 'Dodane przepisy';

  @override
  String get newRecipe_units => 'szt:g:dag:kg:ml:l:szkl.:łyż.:łyżecz.';

  @override
  String get newRecipe_loginToAdd => 'Zaloguj się, aby dodać przepis!';

  @override
  String get newRecipe_addedSuccessfully => 'Przepis został dodany pomyślnie';

  @override
  String get newRecipe_wrongForm =>
      'Wypełnij poprawnie wszystkie pola przepisu';

  @override
  String get newRecipe_recipeName => 'Nazwa przepisu';

  @override
  String get newRecipe_ingredients => 'Składniki';

  @override
  String get newRecipe_addIngredient => 'Dodaj składnik';

  @override
  String get newRecipe_recipe => 'Przepis';

  @override
  String get newRecipe_save => 'Zapisz';

  @override
  String get ingredientRow_name => 'Nazwa';

  @override
  String get ingredientRow_amount => 'Ilość';

  @override
  String get ingredientRow_unit => 'Jednostka';

  @override
  String get ingredientRow_tag => 'Tag';
}
