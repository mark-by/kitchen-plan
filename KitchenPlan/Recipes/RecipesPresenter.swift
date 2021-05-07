import UIKit

final class RecipesPresenter {
    weak var view: RecipesViewInput?
    let interactor: RecipesInteractorInput
    let router: RecipesRouterInput
    private var recipes: [RecipesViewModel] = []
    
    
    init(interactor: RecipesInteractorInput, router: RecipesRouterInput) {
        self.interactor = interactor
        self.router = router
    }
    
    func toViewModel(model: ReceiptInfoResponse) -> RecipesViewModel {
        var time: String
        if let unwrappedTime = model.timeToCook {
            time = String(unwrappedTime) + " мин"
        } else {
            time = "~30 мин"
        }
        
        return RecipesViewModel(id: model.id, title: model.title, timeToCook: time, image: model.image)
    }
}

extension RecipesPresenter: RecipesViewOutput {
    func didSelectItem(at index: Int) {
        router.showReceipt(with: recipes[index])
    }
    
    func didScrollEnd() {
        interactor.loadRecipes(since: self.recipes.last?.id ?? 0, limit: 5)
    }
    
    func didLoadView() {
        interactor.loadRecipes(since: 0, limit: 5)
    }
    
    func count() -> Int {
        return recipes.count
    }
    
    func item(idx: Int) -> RecipesViewModel {
        return recipes[idx]
    }
    
}

extension RecipesPresenter: RecipesInteractorOutput {
    func didLoad(recipes: [ReceiptInfoResponse]) {
        self.recipes.append(contentsOf: recipes.map { toViewModel(model: $0)})
        self.view?.reloadData()
    }
}
