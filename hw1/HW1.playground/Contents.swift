import UIKit

struct Recipe: Identifiable {
    let id: UUID = UUID()
    var name: String
    var details: String?
    var credit: String?
    var thumbnailUrl: URL?
    var mealCourse: MealCourse
    enum MealCourse {
        case appetizer
        case mainDish
        case sideDish
        case dessert
    }
    var componentSections: [String]?
    var components: [RecipeComponent]
    var instructions: [Instruction]
    var tags: [String]
    func componentsForSection(sectionLabel:String) -> [RecipeComponent] {
        return components
            .filter { $0.section == sectionLabel }
            .sorted {
                $0.position < $1.position
            }
    }
    var unsectionedComponents: [RecipeComponent] {
        return components
            .filter { $0.section == nil }
    }
    static func mealCourseFilter(course: MealCourse, recipes: [Recipe]) -> [Recipe] {
        return recipes
            .filter { $0.mealCourse == course }
    }
    static func courseSearchAndContinue(course: MealCourse, recipes: [Recipe], completion: ([Recipe]) -> Void){
        completion(mealCourseFilter(course: course, recipes: recipes))
    }
}


struct Instruction {
    var position: Int = 999999
    var instructionText: String
}

struct RecipeComponent: Identifiable {
    let id: UUID = UUID()
    var position: Int = 999999
    var section: String?
    var ingredient: Ingredient
    var name: String?
    var quantity: Double?
    var unit: String?
    var note: String?
}

struct Ingredient: Identifiable {
    let id: UUID = UUID()
    let name: String
}

Recipe.courseSearchAndContinue(course: .sideDish, recipes: Recipe.previewData) {recipes in recipes.forEach {print($0.name)}}

func printIngredientComponents(recipe: Recipe) {
    for case let thing in recipe.componentSections! {
        print(thing.uppercased())
        for case let thing2 in recipe.components {
            if thing2.section == thing{
                print(thing2.ingredient.name)
            }
        }
    }
}



printIngredientComponents(recipe: Recipe.previewData[0])


extension Recipe {
  static let previewData: [Recipe] = [
    Recipe(
      name: "Gong Bao Chicken With Peanuts",
      details: "Sichuan favorite",
      credit: "adapted from 'Every Grain of Rice: Simple Chinese Home Cooking', by Fuchsia Dunlop (W.W. Norton & Company, 2013)",
      thumbnailUrl: URL(string: "https://education-jrp.s3.amazonaws.com/RecipeImages/KungPaoChicken.png"),
      mealCourse: .mainDish,
      componentSections: ["Chicken", "Marinade", "Sauce"],
      components: [
        RecipeComponent(position: 1, section: "Chicken", ingredient: Ingredient(name: "boneless chicken breasts"), quantity: 2, note: "(11 to 12 ounces total), with or without skin"),
        RecipeComponent(position: 2, section: "Chicken", ingredient: Ingredient(name: "garlic"), quantity: 3, unit: "cloves"),
        RecipeComponent(position: 3, section: "Chicken", ingredient: Ingredient(name: "ginger"), unit: "An equivalent amount of"),
        RecipeComponent(position: 4, section: "Chicken", ingredient: Ingredient(name: "spring onions"), quantity: 5, note: "white parts only"),
        RecipeComponent(position: 5, section: "Chicken", ingredient: Ingredient(name: "dried chiles"), unit: "A handful of"),
        RecipeComponent(position: 6, section: "Chicken", ingredient: Ingredient(name: "cooking oil"), quantity: 2, unit: "Tbsp"),
        RecipeComponent(position: 7, section: "Chicken", ingredient: Ingredient(name: "Sichuan Pepper"), quantity: 1, unit: "tsp", note: "whole, toasted"),
        RecipeComponent(position: 8, section: "Chicken", ingredient: Ingredient(name: "roasted peanuts"), quantity: 75, unit: "grams", note: "see note"),
        RecipeComponent(position: 9, section: "Marinade", ingredient: Ingredient(name: "salt"), quantity: 0.5, unit: "tsp"),
        RecipeComponent(position: 10, section: "Marinade", ingredient: Ingredient(name: "light soy sauce"), quantity: 2, unit: "tsp"),
        RecipeComponent(position: 11, section: "Marinade", ingredient: Ingredient(name: "Shaoxing wine"), quantity: 1, unit: "tsp", note: "or use dry sherry or dry vermouth"),
        RecipeComponent(position: 12, section: "Marinade", ingredient: Ingredient(name: "potato starch or corn starch"), quantity: 1.5, unit: "tsp"),
        RecipeComponent(position: 13, section: "Sauce", ingredient: Ingredient(name: "sugar"), quantity: 1, unit: "Tbsp"),
        RecipeComponent(position: 14, section: "Sauce", ingredient: Ingredient(name: "potato starch or corn starch"), quantity: 0.75, unit: "tsp"),
        RecipeComponent(position: 15, section: "Sauce", ingredient: Ingredient(name: "dark soy sauce"), quantity: 1, unit: "tsp"),
        RecipeComponent(position: 16, section: "Sauce", ingredient: Ingredient(name: "light soy sauce"), quantity: 1, unit: "tsp"),
        RecipeComponent(position: 17, section: "Sauce", ingredient: Ingredient(name: "Chinkiang vinegar"), quantity: 1, unit: "Tbsp", note: "or use balsamic vinegar"),
        RecipeComponent(position: 18, section: "Sauce", ingredient: Ingredient(name: "seasame oil"), quantity: 1, unit: "tsp"),
        RecipeComponent(position: 18, section: "Sauce", ingredient: Ingredient(name: "chicken stock"), quantity: 1, unit: "Tbsp", note: "or water")
      ],
      instructions: [
        Instruction(position: 1, instructionText: "Cut chicken as evenly as possible into half-inch strips, then cut strips into small cubes. Place in a small bowl. Add marinade ingredients and 1 tablespoon water to bowl. Mix well and set aside."),
        Instruction(position: 2, instructionText: "Peel and thinly slice garlic and ginger. Chop spring onions into chunks as long as their diameter (to match the chicken cubes). Snip chiles in half or into sections, discarding their seeds."),
        Instruction(position: 3, instructionText: "In a small bowl, combine the sauce ingredients."),
        Instruction(position: 4, instructionText: "Heat a seasoned wok over a high flame. Add oil, chiles and Sichuan pepper and stir-fry briefly until chiles are darkening but not burned. (Remove wok from heat if necessary to prevent overheating.)"),
        Instruction(position: 5, instructionText: "Quickly add chicken and stir-fry over a high flame, stirring constantly. As soon as chicken cubes have separated, add ginger, garlic and spring onions and continue to stir-fry until they are fragrant and meat is just cooked through (test one of the larger pieces to make sure)."),
        Instruction(position: 6, instructionText: "Give sauce a stir and add to wok, continuing to stir and toss. As soon as the sauce has become thick and shiny, add the peanuts, stir them in and serve.")
      ]
      ,
      tags: ["peanuts", "chicken", "Sichuan"]
    ),
    Recipe(
      name: "Green Beans with Miso Butter",
      details: "A great all purpose side dish. Those unfamiliar with miso will wonder what makes the dish so good.",
      credit: "Adapted from the May 2012 issue of Bon Appetit magazine from a recipe by Patrick Fleming from Boke Bowl in Portland, Oregon",
      thumbnailUrl: URL(string: "https://education-jrp.s3.amazonaws.com/RecipeImages/MisoGreenBeans.jpg"),
      mealCourse: .sideDish,
      components: [
        RecipeComponent(position: 1, ingredient: Ingredient(name: "green beans"), quantity: 0.5, unit: "pound", note: "trimmed"),
        RecipeComponent(position: 2, ingredient: Ingredient(name: "unsalted butter"), unit: "2 Tbsp plus 2 tsp", note: "room temperature"),
        RecipeComponent(position: 3, ingredient: Ingredient(name: "miso"), quantity: 2, unit: "tsp"),
        RecipeComponent(position: 3, ingredient: Ingredient(name: "vegetable oil"), quantity: 2, unit: "Tbsp"),
        RecipeComponent(position: 3, ingredient: Ingredient(name: "kosher salt and freshly ground black pepper")),
        RecipeComponent(position: 3, ingredient: Ingredient(name: "shallot"), quantity: 2, unit: "tsp", note: "minced"),
        RecipeComponent(position: 3, ingredient: Ingredient(name: "garlic"), quantity: 1, unit: "clove", note: "minced"),
        RecipeComponent(position: 3, ingredient: Ingredient(name: "sake"), quantity: 0.25, unit: "cup"),
        RecipeComponent(position: 3, ingredient: Ingredient(name: "vegetable broth"), quantity: 0.25, unit: "cup", note: "or water"),
        RecipeComponent(position: 3, ingredient: Ingredient(name: "sesame seeds"), note: "optional")
      ],
      instructions: [
        Instruction(position: 1, instructionText: "Whisk butter with miso in a small bowl"),
        Instruction(position: 2, instructionText: "Put green beans in a bowl and microwave for 4-5 minutes until just getting tender. Drain the beans and pat them dry."),
        Instruction(position: 3, instructionText: "Heat vegetable oil in a large skillet over medium-high heat. Add the beans to the skillet and season with salt and pepper. Toss."),
        Instruction(position: 4, instructionText: "Stir in shallot and garlic and cook for 1 minute."),
        Instruction(position: 5, instructionText: "Add sake and cook until evaporated, 1-2 minutes."),
        Instruction(position: 6, instructionText: "Add vegetable broth or water; cook until the sauce thickens and reduces by half, 1 minute or so."),
        Instruction(position: 7, instructionText: "Lower heat to medium; add miso butter mixture and stir until a creamy sauce forms. Garnish with sesame seeds, if desired."),
      ]
      ,
      tags: ["vegetarian", "vegetables"]
    ),
    Recipe(
      name: "Dry-fried Green Beans",
      details: "Sichuan favorite",
      thumbnailUrl: URL(string: "https://education-jrp.s3.amazonaws.com/RecipeImages/SichuanGreenBeans.jpg"),
      mealCourse: .sideDish,
      componentSections: ["Sauce", "Aromatics"],
      components: [
        RecipeComponent(position: 1, section: "Sauce", ingredient: Ingredient(name: "Soy Sauce"), quantity: 3, unit: "Tbsp"),
        RecipeComponent(position: 1, section: "Sauce", ingredient: Ingredient(name: "Soybean Paste"), quantity: 1, unit: "Tbsp"),
        RecipeComponent(position: 1, section: "Sauce", ingredient: Ingredient(name: "Shaoxing wine"), quantity: 2, unit: "Tbsp", note: "Or dry sherry"),
        RecipeComponent(position: 1, section: "Sauce", ingredient: Ingredient(name: "Sugar"), quantity: 2, unit: "tsp"),
        RecipeComponent(position: 1, section: "Sauce", ingredient: Ingredient(name: "Cornstarch"), quantity: 1, unit: "tsp"),
        RecipeComponent(position: 1, section: "Sauce", ingredient: Ingredient(name: "Red Pepper Flakes"), quantity: 0.5, unit: "tsp"),
        RecipeComponent(position: 1, section: "Sauce", ingredient: Ingredient(name: "White Pepper"), quantity: 0.5, unit: "tsp", note: "ground"),
        RecipeComponent(position: 1, section: "Sauce", ingredient: Ingredient(name: "Water"), quantity: 4, unit: "Tbsp", note: "ground"),
        RecipeComponent(position: 1, ingredient: Ingredient(name: "Green Beans"), quantity: 1, unit: "pound"),
        RecipeComponent(position: 1, ingredient: Ingredient(name: "Vegetable Oil"), quantity: 2, unit: "Tbsp"),
        RecipeComponent(position: 1, ingredient: Ingredient(name: "Ground Pork"), quantity: 0.25, unit: "pound", note: "optional"),
        RecipeComponent(position: 1, ingredient: Ingredient(name: "Scallions"), quantity: 3, note: "white and light green parts sliced thin"),
        RecipeComponent(position: 1, ingredient: Ingredient(name: "Toasted Sesame Oil"), quantity: 1, unit: "tsp"),
        RecipeComponent(position: 1, section: "Aromatics", ingredient: Ingredient(name: "Sichuan peppercorns"), quantity: 1, unit: "tsp", note: "ground, optional"),
        RecipeComponent(position: 2, section: "Aromatics", ingredient: Ingredient(name: "garlic"), quantity: 3, unit: "medium cloves", note: "minced, about 1 Tbsp."),
        RecipeComponent(position: 3, section: "Aromatics", ingredient: Ingredient(name: "ginger"), quantity: 1, unit: "Tbsp", note: "minced (not grated)"),
        RecipeComponent(position: 4, section: "Aromatics", ingredient: Ingredient(name: "fermented mustard greens"), quantity: 3, unit: "Tbsp", note: "This ingredient is uncommon but vital.")
      ],
      instructions: [
        Instruction(position: 1, instructionText: "Prepare the sauce by mixing in small bowl: soy sauce, soybean paste, sugar, cornstartch, white pepper, pepper flakes, and water. Set this aside."),
        Instruction(position: 2, instructionText: "Heat oil in a wok or 12-inch nonstick skillet over high heat. Add the green beans and cook, stirring often, until beans are slightly tender and are shriveled and blackened in spots. This should take 4-8 minutes. Remove the beans from the pan."),
        Instruction(position: 3, instructionText: "If you are including the ground pork, reduce the heat to medium-high and add the pork to the pan. Cook the pork for 2 minutes, breaking it up into small pieces."),
        Instruction(position: 4, instructionText: "At medium-high heat add the aromatics (garlic, ginger, mustard greens, and optional peppercorns) to the pan (keeping the pork in the pan if using.) Stir until the garlic and ginger are fragant, around 30 seconds."),
        Instruction(position: 5, instructionText: "Give the sauce (still in the small bowl) another stir and then add it to the pan. Add the green beans. Stir to combine and cook until the suace thickens, 10-15 seconds. Remove pan from heat and stir in scallions and sesame oil.")
      ]
      ,
      tags: ["Sichuan", "Vegetable"]
    )
  ]
}
