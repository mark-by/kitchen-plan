import Foundation
import RealmSwift

class MyRecipe: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var image: String = ""
    // @objc dynamic var timeToCook: Int = 0
    @objc dynamic var type: String = ""
    dynamic var ingredients = List<String>()
    dynamic var steps = List<String>()
}
