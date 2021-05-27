import Foundation

final class FavoritesPresenter {
	weak var view: FavoritesViewInput?
    weak var moduleOutput: FavoritesModuleOutput?

	private let router: FavoritesRouterInput
	private let interactor: FavoritesInteractorInput
    
    private var recipes = [RecipesViewModel]()
    
    init(router: FavoritesRouterInput, interactor: FavoritesInteractorInput) {
        self.router = router
        self.interactor = interactor
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
    
    func getFavorites() -> [Int] {
        UserDefaults.standard.array(forKey: "favorites") as? [Int] ?? []
    }
}

extension FavoritesPresenter: FavoritesModuleInput {
}

extension FavoritesPresenter: FavoritesViewOutput {
    func didScrollEnd() {
        interactor.loadRecipes(since: self.recipes.last?.id ?? 0, recipes: getFavorites())
    }
    
    func didLoadView() {
        let favorites = getFavorites()
        if favorites.count == 0 {
            return
        }
        self.recipes = []
        interactor.loadRecipes(since: 0, recipes: favorites)
    }
    
    func count() -> Int {
        recipes.count
    }
    
    func item(idx: Int) -> RecipesViewModel {
        recipes[idx]
    }
    
    func didSelectItem(at index: Int) {
        router.showReceipt(with: recipes[index])
    }
    
}

extension FavoritesPresenter: FavoritesInteractorOutput {
    func didLoad(recipes: [ReceiptInfoResponse]) {
        self.recipes.append(contentsOf: recipes.map { toViewModel(model: $0)})
        self.view?.reloadData()
    }
    
    func didReceive() {
        
    }
}
