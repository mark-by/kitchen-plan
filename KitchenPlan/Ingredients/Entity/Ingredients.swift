import UIKit

struct IngredientsViewModel {
    let id: Int
    let title: String
    let image: String
}

struct IngredientsInfoResponse: Decodable {
    let id: Int
    let title: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case image
    }
}
