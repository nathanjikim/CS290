import UIKit

struct RecipeComponent: Identifiable, Hashable {
    let id: UUID = UUID()
    var position: Int = 999999
    var section: String?
    var ingredient: Ingredient
    var name: String?
    var quantity: Double?
    var unit: String?
    var note: String?
}
