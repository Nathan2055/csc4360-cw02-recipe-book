import 'package:flutter/material.dart';
import 'recipe.dart';

class RecipeHelpers {
  // Define recipes here to be imported into the app
  List<Recipe> getRecipeList() {
    List<Recipe> list = [
      Recipe(1, 'name1', 'ingredients1', 'instructions1'),
      Recipe(2, 'name2', 'ingredients2', 'instructions2'),
      Recipe(3, 'name3', 'ingredients3', 'instructions3'),
      Recipe(4, 'name4', 'ingredients4', 'instructions4'),
    ];
    return list;
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
