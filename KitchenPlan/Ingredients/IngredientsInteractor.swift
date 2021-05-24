import Foundation

final class IngredientsInteractor {
    weak var output: IngredientsInteractorOutput?
    var isFetching = false
    private let ingredientsManager: IngredientsManagerDescription = IngredientsManager.shared
}

extension IngredientsInteractor: IngredientsInteractorInput {
    func delete(for id: Int) {
        ingredientsManager.delete(for: id)
    }

    func load() {
        output?.didLoad(with: ingredientsManager.getIngredients())
    }

    func save(in model: IngredientViewModel) {
        ingredientsManager.save(in: model)
    }
}
