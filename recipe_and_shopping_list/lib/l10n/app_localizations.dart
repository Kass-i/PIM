import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pl'),
  ];

  /// No description provided for @main_appTitle.
  ///
  /// In en, this message translates to:
  /// **'Recipe & Shopping List'**
  String get main_appTitle;

  /// No description provided for @main_widgetTitles.
  ///
  /// In en, this message translates to:
  /// **'Recipes:Add new recipe:Shopping List'**
  String get main_widgetTitles;

  /// No description provided for @main_bottomNavBarRecipe.
  ///
  /// In en, this message translates to:
  /// **'Recipes'**
  String get main_bottomNavBarRecipe;

  /// No description provided for @main_bottomNavBarNewRecipe.
  ///
  /// In en, this message translates to:
  /// **'New recipe'**
  String get main_bottomNavBarNewRecipe;

  /// No description provided for @main_bottomNavBarCart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get main_bottomNavBarCart;

  /// No description provided for @main_guest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get main_guest;

  /// No description provided for @main_login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get main_login;

  /// No description provided for @main_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get main_logout;

  /// No description provided for @main_darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get main_darkMode;

  /// No description provided for @main_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get main_language;

  /// No description provided for @recipes_notInEditMode.
  ///
  /// In en, this message translates to:
  /// **'The cart is not in the edit mode!'**
  String get recipes_notInEditMode;

  /// No description provided for @recipes_recipeAddedToCart.
  ///
  /// In en, this message translates to:
  /// **'The recipe was added to the cart'**
  String get recipes_recipeAddedToCart;

  /// No description provided for @recipes_areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get recipes_areYouSure;

  /// No description provided for @recipes_yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get recipes_yes;

  /// No description provided for @recipes_no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get recipes_no;

  /// No description provided for @recipes_noRecipes.
  ///
  /// In en, this message translates to:
  /// **'No recipes'**
  String get recipes_noRecipes;

  /// No description provided for @recipes_ingredients.
  ///
  /// In en, this message translates to:
  /// **'Ingredients:'**
  String get recipes_ingredients;

  /// No description provided for @recipes_instructions.
  ///
  /// In en, this message translates to:
  /// **'Instructions:'**
  String get recipes_instructions;

  /// No description provided for @cart_noTag.
  ///
  /// In en, this message translates to:
  /// **'No tag'**
  String get cart_noTag;

  /// No description provided for @cart_willUncheck.
  ///
  /// In en, this message translates to:
  /// **'When you turn on edit mode, all ingredients will become unchecked.'**
  String get cart_willUncheck;

  /// No description provided for @cart_emptyCart.
  ///
  /// In en, this message translates to:
  /// **'Empty cart'**
  String get cart_emptyCart;

  /// No description provided for @cart_editMode.
  ///
  /// In en, this message translates to:
  /// **'Edit mode'**
  String get cart_editMode;

  /// No description provided for @cart_addedRecipes.
  ///
  /// In en, this message translates to:
  /// **'Added recipes'**
  String get cart_addedRecipes;

  /// No description provided for @newRecipe_units.
  ///
  /// In en, this message translates to:
  /// **'pcs:g:dag:kg:ml:l:cup:tbsp:tsp'**
  String get newRecipe_units;

  /// No description provided for @newRecipe_loginToAdd.
  ///
  /// In en, this message translates to:
  /// **'Login to add the recipe!'**
  String get newRecipe_loginToAdd;

  /// No description provided for @newRecipe_addedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'The recipe added successfully'**
  String get newRecipe_addedSuccessfully;

  /// No description provided for @newRecipe_wrongForm.
  ///
  /// In en, this message translates to:
  /// **'Fill all recipe fields correctly'**
  String get newRecipe_wrongForm;

  /// No description provided for @newRecipe_recipeName.
  ///
  /// In en, this message translates to:
  /// **'Recipe name'**
  String get newRecipe_recipeName;

  /// No description provided for @newRecipe_ingredients.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get newRecipe_ingredients;

  /// No description provided for @newRecipe_addIngredient.
  ///
  /// In en, this message translates to:
  /// **'Add ingredient'**
  String get newRecipe_addIngredient;

  /// No description provided for @newRecipe_recipe.
  ///
  /// In en, this message translates to:
  /// **'Recipe'**
  String get newRecipe_recipe;

  /// No description provided for @newRecipe_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get newRecipe_save;

  /// No description provided for @ingredientRow_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get ingredientRow_name;

  /// No description provided for @ingredientRow_amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get ingredientRow_amount;

  /// No description provided for @ingredientRow_unit.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get ingredientRow_unit;

  /// No description provided for @ingredientRow_tag.
  ///
  /// In en, this message translates to:
  /// **'Tag'**
  String get ingredientRow_tag;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pl':
      return AppLocalizationsPl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
