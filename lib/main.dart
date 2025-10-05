import 'package:flutter/material.dart';
import 'recipe.dart';
import 'recipe_helpers.dart';

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
            children: [
              Card(
                child: ListTile(
                  leading: Icon(Icons.file_present),
                  title: Text('Item 1'),
                  subtitle: Text('Item 1'),
                ),
              ),
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(Icons.folder_shared),
                      title: Text('Item 2'),
                      subtitle: Text('Item 2'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // TODO: generalize
  List<Card> getRecipeCards() {
    List<Recipe> recipeList = RecipeHelpers().getRecipeList();
    List<Card> cards = [];

    for (int i = 0; i < recipeList.length; i++) {
      cards.add(RecipeHelpers().recipeToCard(recipeList[i]));
    }
    return cards;
  }
}
