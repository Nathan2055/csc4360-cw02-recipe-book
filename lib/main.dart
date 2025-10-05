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

  // Favorites list definition
  List favorites = [];

  // Add a favorites
  // The if checks for and prevents duplicates in the list
  void _addFavorite(int id) {
    setState(() {
      if (!favorites.contains(id)) {
        favorites.add(id);
      }
    });
  }

  // Remove a favorite
  // While remove() deletes only one instance of the id, the duplicate
  // check in the _addFavorite() method prevents this from causing issues
  void _removeFavorite(int id) {
    setState(() {
      favorites.remove(id);
    });
  }

  @override
  void initState() {
    super.initState();
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
          title: Text('Recipe Book'),
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
        body: listTab(),
      ),
    );
  }

  // Main interface
  Column homeTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Part 1: Counter
        const Text(
          'You have pushed the button this many times:',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }

  // Main interface
  Column listTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: false,
            padding: const EdgeInsets.all(8),
            children: getRecipeCards(),
          ),
        ),
      ],
    );
  }

  // Create a list of recipe cards
  // TODO: generalize to any List<Recipe>
  List<Card> getRecipeCards() {
    List<Card> cards = [];
    for (int i = 0; i < recipeList.length; i++) {
      cards.add(recipeToCard(recipeList[i]));
    }
    return cards;
  }

  // Convert a single Recipe into a single Material Card
  Card recipeToCard(Recipe input) {
    Card output = Card(
      child: ListTile(
        onTap: () {
          // TODO: add some logic to show the details screen
          debugPrint('Card tapped.');
        },
        leading: Icon(Icons.restaurant),
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
}

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
