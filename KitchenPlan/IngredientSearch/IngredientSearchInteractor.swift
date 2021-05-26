//
//  IngredientSearchInteractor.swift
//  KitchenPlan
//
//  Created by Artem on 22.05.2021.
//  
//

import Foundation

final class IngredientSearchInteractor {
    weak var output: IngredientSearchInteractorOutput?

    private func search(title: String, completion: @escaping (Result<[IngredientViewModel], Error>) -> Void) {
        guard let url = URL(string: backHost + genPath(title)) else {
            completion(.failure(NetworkError.unexpected))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.unexpected))
                return
            }

            let json = JSONDecoder()

            do {
                let result = try json.decode([IngredientViewModel].self, from: data)
                completion(.success(result))
            } catch let error {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}

extension IngredientSearchInteractor: IngredientSearchInteractorInput {
    func load(text: String) {
        search(title: text) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let ingredients):
                    self?.output?.didLoad(with: ingredients)
                case .failure(let error):
                    print("Fail to fetch recipes ", error)
                    self?.output?.didRecieve()
                }
            }
        }
    }
}

func genPath(_ title: String) -> String {
    let path = "/ingredients?title=\(title)"
    return path.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? path
}
