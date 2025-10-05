import 'recipe.dart';

class RecipeBuilder {
  List<Recipe> getRecipeList() {
    var list = [
      Recipe(1, 'name1', 'ingredients1', 'instructions1'),
      Recipe(2, 'name2', 'ingredients2', 'instructions2'),
      Recipe(3, 'name3', 'ingredients3', 'instructions3'),
      Recipe(4, 'name4', 'ingredients4', 'instructions4'),
    ];
    return list;
  }
}
