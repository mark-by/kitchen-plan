import Foundation

struct Ingredient: Decodable {
    let id: Int
    let title: String
    let image: String?
    let measure: String?
    let quantity: Float?
}
