import Foundation

final class IngredientsInteractor {
    weak var output: IngredientsInteractorOutput?
    var isFetching = false
    private let ingredientsManager: IngredientsManagerDescription = IngredientsManager.shared
}

extension IngredientsInteractor: IngredientsInteractorInput {
        func loadIngredients(title: String?) {
        if isFetching {
            return
        }

        isFetching = true
            ingredientsManager.loadIngredients(title: title) { [weak self] (result) in DispatchQueue.main.async {
            switch result {
            case .success(let ingredients):
                self?.output?.didLoad(ingredients: ingredients)
                self?.isFetching = false
            case .failure(let error):
                print(error)
                self?.output?.didReceive()
                self?.isFetching = false
            }
        }
    }
}
}
