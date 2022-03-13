import UIKit

struct Ingredient: Identifiable, Hashable {
    let id: UUID = UUID()
    let name: String
}
