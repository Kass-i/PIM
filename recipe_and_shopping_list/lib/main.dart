import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:recipe_and_shopping_list/firebase_options.dart';
import 'package:recipe_and_shopping_list/l10n/app_localizations.dart';
import 'package:recipe_and_shopping_list/pages/cart_page.dart';
import 'package:recipe_and_shopping_list/pages/new_recipe_page.dart';
import 'package:recipe_and_shopping_list/pages/recipes_page.dart';
import 'package:recipe_and_shopping_list/providers/cart_provider.dart';
import 'package:recipe_and_shopping_list/providers/recipes_provider.dart';
import 'package:recipe_and_shopping_list/providers/auth_provider.dart';
import 'package:recipe_and_shopping_list/providers/theme_provider.dart';
import 'package:recipe_and_shopping_list/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, RecipesProvider>(
          create: (_) => RecipesProvider(),
          update: (_, auth, recipes) => recipes!..updateUser(auth.currentUser),
        ),
        ChangeNotifierProxyProvider<AuthProvider, CartProvider>(
          create: (_) => CartProvider()..loadCart(),
          update: (_, auth, cart) => cart!..updateUser(auth.currentUser),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Recipe & Shopping List',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('en'), Locale('pl')],
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = [
    RecipesPage(),
    NewRecipePage(),
    ShoppingListPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final trans = AppLocalizations.of(context)!;
    final List<String> title = trans.main_widgetTitles.split(':');

    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;

    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    return Scaffold(
      body: Container(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: trans.main_bottomNavBarRecipe,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ramen_dining),
            label: trans.main_bottomNavBarNewRecipe,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: trans.main_bottomNavBarCart,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      appBar: AppBar(title: Text(title[_selectedIndex])),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              accountName: Text(
                user?.displayName ?? trans.main_guest,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              accountEmail: Text(
                user?.email ?? "",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              currentAccountPictureSize: Size.square(50),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundImage: user?.photoURL != null
                    ? NetworkImage(user!.photoURL!)
                    : null,
                child: user?.photoURL == null
                    ? Icon(
                        Icons.person,
                        size: 40,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      )
                    : null,
              ),
            ),
            // ListTile(
            //   leading: const Icon(Icons.settings),
            //   title: const Text('Settings'),
            //   onTap: () {},
            // ),
            ListTile(
              leading: const Icon(Icons.login),
              title: Text(user == null ? trans.main_login : trans.main_logout),
              onTap: () {
                user == null
                    ? authProvider.signInWithGoogle()
                    : authProvider.signOut();
              },
            ),
            const Divider(),
            SwitchListTile(
              title: Text(trans.main_darkMode),
              secondary: const Icon(Icons.dark_mode_outlined),
              value: isDark,
              onChanged: themeProvider.toggleTheme,
            ),
          ],
        ),
      ),
    );
  }
}
