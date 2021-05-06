import UIKit

struct RecipesViewModel {
    let id: Int
    let title: String
    let timeToCook: String
    let image: String
}

struct ReceiptInfoResponse: Decodable {
    let id: Int
    let title: String
    let timeToCook: Int?
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case timeToCook = "time_to_cook"
        case image
    }
}
