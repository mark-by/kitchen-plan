import UIKit

final class RecipesPresenter {
    weak var view: RecipesViewInput?
    let interactor: RecipesInteractorInput
    let router: RecipesRouterInput
    private var recipes: [RecipesViewModel] = []
    
    private var searchText: String?
    private var searchType: String?
    private (set) var searchByIngredients: Bool = false
    private var ingredients = [Int]()
    
    init(interactor: RecipesInteractorInput, router: RecipesRouterInput) {
        self.interactor = interactor
        self.router = router
        
        self.ingredients = interactor.havingIngredients()
        searchByIngredients = UserDefaults.standard.bool(forKey: "search_by_ingredients")
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
    
    func serveIngredientsFilter() -> [Int] {
        if searchByIngredients {
            return self.ingredients
        }
        return []
    }
}

extension RecipesPresenter: RecipesViewOutput {
    func didSelectItem(at index: Int) {
        router.showReceipt(with: recipes[index])
    }
    
    func didScrollEnd() {
        interactor.loadRecipes(since: self.recipes.last?.id ?? 0,
                               limit: 5, title: searchText,
                               type: searchType, ingredients: serveIngredientsFilter())
    }
    
    func didLoadView() {
        setDefautlType()
        interactor.loadRecipes(since: 0, limit: 5,
                               title: nil, type: searchType,
                               ingredients: serveIngredientsFilter())
    }
    
    func setDefautlType() {
        let userDefaults = UserDefaults.standard
        if let type = userDefaults.string(forKey: "receipt_type") {
            searchType = String(type.dropLast())
        } else {
            searchType = nil
        }
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
        interactor.loadRecipes(since: 0, limit: 5, title: text,
                               type: searchType, ingredients: serveIngredientsFilter())
    }
    
    func didSelectType(type: String?) {
        if searchType == type {
            return
        }
        searchType = type
        self.recipes = []
        interactor.loadRecipes(since: 0, limit: 5, title: searchText,
                               type: searchType, ingredients: serveIngredientsFilter())
    }
    
    func didToggleIngredients(isActive: Bool) {
        searchByIngredients = isActive
        UserDefaults.standard.setValue(isActive, forKey: "search_by_ingredients")
        self.recipes = []
        interactor.loadRecipes(since: 0, limit: 5, title: searchText,
                               type: searchType, ingredients: serveIngredientsFilter())
    }
    
    func didSelectFromMenu() {
        let havingIngredients = interactor.havingIngredients()
        if !searchByIngredients {
            self.ingredients = havingIngredients
            return
        }
        if self.ingredients == havingIngredients {
            return
        }
        self.ingredients = havingIngredients
        self.recipes = []
        interactor.loadRecipes(since: 0, limit: 5, title: searchText,
                               type: searchType, ingredients: serveIngredientsFilter())
    }
    
    func didReceive() {
        view?.reloadData()
    }
    
    func selected() -> (String?, Bool) {
        return (searchType, searchByIngredients && canFilterByIngredients())
    }
    
    func count() -> Int {
        return recipes.count
    }
    
    func item(idx: Int) -> RecipesViewModel {
        return recipes[idx]
    }
    
    func canFilterByIngredients() -> Bool {
        return interactor.havingIngredients().count > 0
    }
}

extension RecipesPresenter: RecipesInteractorOutput {
    func didLoad(recipes: [ReceiptInfoResponse]) {
        self.recipes.append(contentsOf: recipes.map { toViewModel(model: $0)})
        self.view?.reloadData()
    }
}
