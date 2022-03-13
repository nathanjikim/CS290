import UIKit

struct Recipe: Identifiable {
    let id: UUID = UUID()
    var name: String
    var details: String?
    var credit: String?
    var thumbnailUrl: URL?
    var mealCourse: MealCourse
    enum MealCourse: String {
        case appetizer = "APPETIZER"
        case mainDish = "MAIN"
        case sideDish = "SIDE"
        case dessert = "DESSERT"
    }
    var componentSections: [String]?
    var components: [RecipeComponent]
    var instructions: [Instruction]
    var tags: [String]
    var lastPreparedAt: Date? = nil
    var scaleValue: Double = 1.0
    var searchableString: String {
        "\(tags.joined(separator: " "))".lowercased()
    }
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
