import Foundation

struct Receipt {
    let id: Int
    let image: String
    let title: String
    let time: Int
    let type: String
    let steps: [String]
    let ingredients: [Ingredient]
}
