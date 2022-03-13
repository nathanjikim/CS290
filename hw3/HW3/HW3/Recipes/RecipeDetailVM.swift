import Foundation
import Combine

class RecipeDetailVM: ObservableObject {
  enum State {
    case loading
    case loaded
  }
  private var recipeStore: RecipeStore
  private var cancellables: Set<AnyCancellable> = []
  private var recipeId: UUID

    @Published var recipe: Recipe = Recipe(name: "Loading", mealCourse: .mainDish, components: [RecipeComponent(position: 1, section: "Chicken", ingredient: Ingredient(name: "boneless chicken breasts"), quantity: 2, note: "(11 to 12 ounces total), with or without skin")], instructions: [
        Instruction(position: 1, instructionText: "Cut chicken as evenly as possible into half-inch strips, then cut strips into small cubes. Place in a small bowl. Add marinade ingredients and 1 tablespoon water to bowl. Mix well and set aside."),
        Instruction(position: 2, instructionText: "Peel and thinly slice garlic and ginger. Chop spring onions into chunks as long as their diameter (to match the chicken cubes). Snip chiles in half or into sections, discarding their seeds."),
        Instruction(position: 3, instructionText: "In a small bowl, combine the sauce ingredients."),
        Instruction(position: 4, instructionText: "Heat a seasoned wok over a high flame. Add oil, chiles and Sichuan pepper and stir-fry briefly until chiles are darkening but not burned. (Remove wok from heat if necessary to prevent overheating.)"),
        Instruction(position: 5, instructionText: "Quickly add chicken and stir-fry over a high flame, stirring constantly. As soon as chicken cubes have separated, add ginger, garlic and spring onions and continue to stir-fry until they are fragrant and meat is just cooked through (test one of the larger pieces to make sure)."),
        Instruction(position: 6, instructionText: "Give sauce a stir and add to wok, continuing to stir and toss. As soon as the sauce has become thick and shiny, add the peanuts, stir them in and serve.")
      ], tags: ["peanuts", "chicken", "Sichuan"])
  @Published var state: State = .loading
  @Published var editSheetIsPresenting: Bool = false

  init(recipeStore: RecipeStore, recipeId: UUID) {
    self.recipeStore = recipeStore
    self.recipeId = recipeId

    recipeStore.$recipes
      .sink{ [weak self] storeRecipes in
        if let recipe = storeRecipes.filter({ $0.id == self?.recipeId }).first {
          self?.recipe = recipe
          self?.state = .loaded
        }
      }
      .store(in: &cancellables)
  }
    func editButtonTapped() {
      self.editSheetIsPresenting = true
    }
    func editButtonBegone() {
        self.editSheetIsPresenting = false
    }
    func preparedButtonTapped() {
      saveRecipe()
    }

    func saveRecipe() {
      recipeStore.updateRecipe(recipe)
    }
  
}
