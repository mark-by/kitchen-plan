import Foundation

final class IngredientsInteractor {
    weak var output: IngredientsInteractorOutput?
    var isFetching = false
    private let ingredientsManager: IngredientsManagerDescription = IngredientsManager.shared
}

extension IngredientsInteractor: IngredientsInteractorInput {
    func delete(for id: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.ingredientsManager.delete(for: id)
            self?.load()
        }
    }

    func load() {
        output?.didLoad(with: ingredientsManager.getIngredients())
    }

    func save(in model: IngredientViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.ingredientsManager.save(in: model)
            self?.load()
        }
    }
}
