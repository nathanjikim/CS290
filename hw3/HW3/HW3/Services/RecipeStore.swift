import Combine

class RecipeStore: ObservableObject  {
    @Published var recipes: [Recipe] = Recipe.previewData

  func createRecipe(_ recipe: Recipe) {
    recipes.append(recipe)
  }

  func updateRecipe(_ recipe: Recipe) {
    if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
      recipes[index] = recipe
    }
  }

  func deleteRecipe(_ recipe: Recipe) {
    if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
      recipes.remove(at: index)
    }
  }
}
