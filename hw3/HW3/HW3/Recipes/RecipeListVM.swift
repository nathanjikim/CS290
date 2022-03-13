import Foundation
import Combine
import SwiftUI

class RecipeListVM: ObservableObject {
  let recipeStore: RecipeStore
  var cancellables: Set<AnyCancellable> = []
  
  @Published var recipes: [Recipe] = []
  @Published var searchText: String = ""
  
  var filteredRecipes: [Recipe] {
    if searchText.isEmpty {
      return recipes
    } else {
        return recipes.filter({ $0.name.lowercased().contains(searchText.lowercased()) || $0.searchableString.lowercased().contains(searchText.lowercased())})
        }
  }
  
  init(recipeStore: RecipeStore) {
    self.recipeStore = recipeStore
    recipeStore.$recipes
      .sink{ [weak self] recipesPublishedFromStore in
        self?.recipes = recipesPublishedFromStore
      }
      .store(in: &cancellables)
  }
  
  func deleteMovie(_ recipe: Recipe) {
    recipeStore.deleteRecipe(recipe)
  }
  
}
