import Foundation

enum NetworkError: Error {
    case unexpected
}

protocol RecipesManagerDescription: AnyObject {
    func loadRecipes(since: Int,
                     limit: Int,
                     title: String?,
                     type: String?,
                     completion: @escaping (Result<[ReceiptInfoResponse], Error>) -> Void)
}

final class RecipesManager {
    static let shared: RecipesManagerDescription = RecipesManager()
}

extension RecipesManager: RecipesManagerDescription {
    func loadRecipes(since: Int,
                     limit: Int,
                     title: String? = nil,
                     type: String? = nil,
                     completion: @escaping (Result<[ReceiptInfoResponse], Error>) -> Void) {
        var path = "/recipes?since=\(since)&limit=\(limit)"
        if let unwrappedTitle = title {
            if unwrappedTitle != "" {
                path += "&title=\(unwrappedTitle)"
            }
        }
        if let unwrappedType = type {
            path += "&type=\(unwrappedType.uppercased())"
        }
        path = path.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? path
        guard let url = URL(string: backHost + path) else {
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
                let result = try json.decode([ReceiptInfoResponse].self, from: data)
                completion(.success(result))
            } catch let error {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
