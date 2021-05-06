import Foundation

protocol ReceiptManagerDescription: AnyObject {
    func loadReceipt(id: Int, completion: @escaping (Result<Receipt, Error>) -> Void)
}

final class ReceiptManager {
    static let shared: ReceiptManagerDescription = ReceiptManager()
}

extension ReceiptManager: ReceiptManagerDescription {
    func loadReceipt(id: Int, completion: @escaping (Result<Receipt, Error>) -> Void) {
        guard let url = URL(string: backHost + "/recipes/" + String(id)) else {
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
                let result = try json.decode(Receipt.self, from: data)
                completion(.success(result))
            } catch let error {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
