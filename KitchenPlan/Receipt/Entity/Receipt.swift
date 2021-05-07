import Foundation

struct Receipt: Decodable {
    let id: Int
    let image: String
    let title: String
    let time: Int?
    let type: String
    let steps: [String]
    let ingredients: [Ingredient]
    
    enum CodingKeys: String, CodingKey {
        case id
        case image
        case title
        case time = "time_to_cook"
        case type
        case steps
        case ingredients
    }
}

struct ReceiptModelView {
    let type: String
    let steps: [String]
    let ingredients: [String]
}
