import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_and_shopping_list/pages/cart_page.dart';
import 'package:recipe_and_shopping_list/pages/new_recipe_page.dart';
import 'package:recipe_and_shopping_list/pages/recipes_page.dart';
import 'package:recipe_and_shopping_list/providers/cart_provider.dart';
import 'package:recipe_and_shopping_list/providers/recipes_provider.dart';
import 'package:recipe_and_shopping_list/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecipesProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString('themeMode') ?? 'system';
    setState(() {
      _themeMode = _parseTheme(savedTheme);
    });
  }

  Future<void> _saveTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', _themeToString(mode));
  }

  String _themeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      default:
        return 'system';
    }
  }

  ThemeMode _parseTheme(String value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
      _saveTheme(_themeMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe & Shopping List',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,
      home: Home(themeMode: _themeMode, onThemeChanged: _toggleTheme),
    );
  }
}

class Home extends StatefulWidget {
  final ThemeMode themeMode;
  final Function(bool) onThemeChanged;

  const Home({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    RecipesPage(),
    NewRecipePage(),
    ShoppingListPage(),
  ];

  final List<String> _title = ["Recipes", "Add new recipe", "Shopping List"];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.themeMode == ThemeMode.dark;

    return Scaffold(
      body: Container(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ramen_dining),
            label: 'New recipe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      appBar: AppBar(title: Text(_title[_selectedIndex])),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              accountName: Text(
                "Kasia X",
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              accountEmail: Text(
                "kasia@gmail.com",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              currentAccountPictureSize: Size.square(50),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text(
                  "K",
                  style: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Login'),
              onTap: () {},
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('Dark mode'),
              secondary: const Icon(Icons.dark_mode_outlined),
              value: isDark,
              onChanged: (value) => widget.onThemeChanged(value),
            ),
          ],
        ),
      ),
    );
  }
}
