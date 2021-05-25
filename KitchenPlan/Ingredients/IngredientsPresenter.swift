import UIKit

final class IngredientsPresenter {
    weak var view: IngredientsViewInput?
    weak var moduleOutput: IngredientsModuleOutput?

    let interactor: IngredientsInteractorInput
    let router: IngredientsRouter

    private var ingredients = [IngredientViewModel]()

    init(router: IngredientsRouter, interactor: IngredientsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension IngredientsPresenter: IngredientsViewOutput, IngredientsInteractorOutput, IngredientSearchModuleOutput, IngredientsModuleInput {
    func didDelete(for idx: Int) {
        interactor.delete(for: idx)

        interactor.load()
        view?.reloadData()
    }

    func didTapAdd() {
        router.showIngredientSearch()
    }

    func didSelectIngredient(with model: IngredientViewModel) {
        let found = self.ingredients.firstIndex { ingredient in
            return ingredient.id == model.id
        }
        if let _ = found {
            view?.close()
            return
        }

        self.ingredients.append(model)
        interactor.save(in: model)
        view?.reloadData()
        view?.close()
    }
    
    func didLoadView() {
        interactor.load()
    }

    func count() -> Int {
        return ingredients.count
    }

    func item(idx: Int) -> IngredientViewModel {
        return ingredients[idx]
    }

    func didSelectItem(at index: Int) {
        router.showIngredient(with: ingredients[index])
    }

    func didReceive() {
        view?.reloadData()
    }

    func didLoad(with ingredients: [IngredientViewModel]) {
        self.ingredients = ingredients
        self.view?.reloadData()
    }
}
