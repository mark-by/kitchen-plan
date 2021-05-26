import Foundation
import RealmSwift

class MyReciept: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var timeToCook: Int = 0
    @objc dynamic var type: Int = 0
//    @objc dynamic var ingredients: [String] = []
//    @objc dynamic var steps: [String] = []
}
