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
