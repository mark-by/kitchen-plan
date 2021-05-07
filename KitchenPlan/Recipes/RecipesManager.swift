import Foundation

enum NetworkError: Error {
    case unexpected
}

protocol RecipesManagerDescription: AnyObject {
    func loadRecipes(since: Int, limit: Int, completion: @escaping (Result<[ReceiptInfoResponse], Error>) -> Void)
}

final class RecipesManager {
    static let shared: RecipesManagerDescription = RecipesManager()
}

extension RecipesManager: RecipesManagerDescription {
    func loadRecipes(since: Int, limit: Int, completion: @escaping (Result<[ReceiptInfoResponse], Error>) -> Void) {
        guard let url = URL(string: backHost + "/recipes?since=\(since)&limit=\(limit)") else {
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
