import Foundation
import RealmSwift

class Ingredient: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var measure: String = ""
    @objc dynamic var quantity: Float = 0
}

struct IngredientViewModel: Decodable {
    let id: Int
    let title: String
    let image: String?
    let measure: String?
    let quantity: Float?
}
