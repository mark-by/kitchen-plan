import UIKit

final class RecipesPresenter {
    weak var view: RecipesViewInput?
    let interactor: RecipesInteractorInput
    let router: RecipesRouterInput
    private var recipes: [RecipesViewModel] = []
    
    private var searchText: String?
    private var searchType: String?
    
    
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
        interactor.loadRecipes(since: self.recipes.last?.id ?? 0, limit: 5, title: searchText, type: searchType)
    }
    
    func didLoadView() {
        interactor.loadRecipes(since: 0, limit: 5, title: nil, type: nil)
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
        self.recipes = []
        interactor.loadRecipes(since: 0, limit: 5, title: text, type: searchType)
    }
    
    func didSelectType(type: String?) {
        if searchType == type {
            return
        }
        searchType = type
        self.recipes = []
        interactor.loadRecipes(since: 0, limit: 5, title: searchText, type: searchType)
    }
    
    func didReceive() {
        view?.reloadData()
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
