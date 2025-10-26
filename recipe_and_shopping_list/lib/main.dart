import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_and_shopping_list/pages/cart_page.dart';
import 'package:recipe_and_shopping_list/pages/new_recipe_page.dart';
import 'package:recipe_and_shopping_list/pages/recipes_page.dart';
import 'package:recipe_and_shopping_list/providers/cart_provider.dart';
import 'package:recipe_and_shopping_list/providers/recipes_provider.dart';

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

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe & Shopping List',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
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
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: _onItemTapped,
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_title[_selectedIndex]),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              accountName: Text("Kasia X", style: TextStyle(fontSize: 20)),
              accountEmail: Text("kasia@gmail.com"),
              currentAccountPictureSize: Size.square(50),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                child: Text(
                  "K",
                  style: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).colorScheme.primary,
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
          ],
        ),
      ),
    );
  }
}
