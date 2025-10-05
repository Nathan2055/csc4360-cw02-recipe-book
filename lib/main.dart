import 'package:flutter/material.dart';

// Main method
void main() {
  runApp(const MyApp());
}

// App constructor
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

// Recipe object definition
class Recipe {
  int id = -1;
  String name = '';
  String ingredients = '';
  String instructions = '';

  Recipe(
    int newid,
    String newname,
    String newingredients,
    String newinstructions,
  ) {
    id = newid;
    name = newname;
    ingredients = newingredients;
    instructions = newinstructions;
  }
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  // Theme control variables
  ThemeMode _themeMode = ThemeMode.light;
  bool darkMode = false;

  // Principle recipe list definition
  final List<Recipe> recipeList = [
    Recipe(1, 'name1', 'ingredients1', 'instructions1'),
    Recipe(2, 'name2', 'ingredients2', 'instructions2'),
    Recipe(3, 'name3', 'ingredients3', 'instructions3'),
    Recipe(4, 'name4', 'ingredients4', 'instructions4'),
  ];

  // Convert a single Recipe into a single Material Card
  Card recipeToCard(Recipe input) {
    Card output = Card(
      child: ListTile(
        onTap: () {
          // TODO: add logic here to show the details screen
          debugPrint('Card tapped.');
        },
        leading: const Icon(Icons.restaurant),
        title: Text(truncateWithEllipsis(20, input.name)),
        subtitle: Text(truncateWithEllipsis(25, input.ingredients)),
      ),
    );
    return output;
  }

  // Truncate a string to a given length while adding ... to the end
  // https://stackoverflow.com/a/56187365
  String truncateWithEllipsis(int cutoff, String myString) {
    return (myString.length <= cutoff)
        ? myString
        : '${myString.substring(0, cutoff)}...';
  }

  // Create a list of recipe cards
  // Converts any List<Recipe> to a List<Card> that can then
  // be passed to an Expanded -> ListView
  List<Card> getRecipeCards(List<Recipe> input) {
    List<Card> cards = [];
    for (int i = 0; i < input.length; i++) {
      cards.add(recipeToCard(input[i]));
    }
    return cards;
  }

  // Favorites list definitions
  List favorites = []; // array of recipe ids
  List<Card> favoritesCards = []; // maintained with _updateFavoritesDisplay

  // Add a favorite
  // The if checks for and prevents duplicates in the list
  void _addFavorite(int id) {
    setState(() {
      if (!favorites.contains(id)) {
        favorites.add(id);
      }
      _updateFavoritesDisplay();
    });
  }

  // Remove a favorite
  // While remove() deletes only one instance of the id, the duplicate
  // check in the _addFavorite() method prevents this from causing issues
  void _removeFavorite(int id) {
    setState(() {
      favorites.remove(id);
      _updateFavoritesDisplay();
    });
  }

  // Update the displayed List<Card> of favorites
  void _updateFavoritesDisplay() {
    setState(() {
      List<Recipe> temp = [];
      for (int i = 0; i < favorites.length; i++) {
        temp.add(recipeList.firstWhere((element) => element.id == i));
      }
      favoritesCards = getRecipeCards(temp);
    });
  }

  @override
  void initState() {
    super.initState();
    _updateFavoritesDisplay();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Recipe Book'),
          actions: <Widget>[
            IconButton(
              // if dark mode, show sun; if light mode, show moon
              icon: darkMode
                  ? const Icon(Icons.sunny)
                  : const Icon(Icons.mode_night),
              // same idea for the tooltip text
              tooltip: darkMode ? 'Light Mode' : 'Dark Mode',
              onPressed: () {
                setState(() {
                  // if on, switch to light mode; if off, switch to dark mode
                  _themeMode = darkMode ? ThemeMode.light : ThemeMode.dark;
                  darkMode = !darkMode;
                });
              },
            ),
          ],
        ),
        body: homeTab(),
      ),
    );
  }

  // Main interface
  Column homeTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: false,
            padding: const EdgeInsets.all(8),
            children: getRecipeCards(recipeList),
          ),
        ),
      ],
    );
  }
}
