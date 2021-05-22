import UIKit

final class IngredientsPresenter {
    weak var view: IngredientsViewInput?
    let interactor: IngredientsInteractorInput
    private var ingredients: [IngredientsViewModel] = []

    private var searchText: String?

    init(interactor: IngredientsInteractorInput) {
        self.interactor = interactor
    }

    func toViewModel(model: IngredientsInfoResponse) -> IngredientsViewModel {
        return IngredientsViewModel(id: model.id, title: model.title, image: model.image)
    }
}

extension IngredientsPresenter: IngredientsViewOutput {
    func didLoadView() {
        interactor.loadIngredients(title: nil)
    }

    func didSearch(text: String) {
        if let unwrap = self.searchText {
            if text == "" {
                self.searchText = nil
            }
            if text == unwrap {
                return
            }
        } else if text == "" {
            return
        }
        self.searchText = text
        self.ingredients = []
        interactor.loadIngredients(title: text)
    }

    func count() -> Int {
        return ingredients.count
    }

    func item(idx: Int) -> IngredientsViewModel {
        return ingredients[idx]
    }

    func didSelectItem(at index: Int) {
        print(index)
    }
}

extension IngredientsPresenter: IngredientsInteractorOutput {
    func didReceive() {
        view?.reloadData()
    }

    func didLoad(ingredients: [IngredientsInfoResponse]) {
        self.ingredients.append(contentsOf: ingredients.map { toViewModel(model: $0)})
        self.view?.reloadData()
    }
}
