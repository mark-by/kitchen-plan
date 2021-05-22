import Foundation

protocol IngredientsManagerDescription: AnyObject {
    func loadIngredients(title: String?, completion: @escaping (Result<[IngredientsInfoResponse], Error>) -> Void)
}

final class IngredientsManager {
    static let shared: IngredientsManagerDescription = IngredientsManager()
}

extension IngredientsManager: IngredientsManagerDescription {
    func loadIngredients(title: String? = nil, completion: @escaping (Result<[IngredientsInfoResponse], Error>) -> Void) {
        guard let url = URL(string: backHost + genPath(
                                title: title)) else {
            completion(.failure(NetworkError.unexpected))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.unexpected))
                return
            }

            let json = JSONDecoder()

            do {
                let result = try json.decode([IngredientsInfoResponse].self, from: data)
                completion(.success(result))
            } catch let error {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}

func genPath(title: String?) -> String {
    var path = "/ingredients"
    if let unwrappedTitle = title {
        if unwrappedTitle != "" {
            path += "?title=\(unwrappedTitle)"
        }
    }
    return path.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? path
}
