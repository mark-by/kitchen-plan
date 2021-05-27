import Foundation

final class MyRecipesPresenter {
    weak var view: MyRecipesViewInput?
    weak var moduleOutput: MyRecipesModuleOutput?
    private var recipes: [RecipesViewModel] = []

    private let router: MyRecipesRouterInput
    private let interactor: MyRecipesInteractorInput

    init(router: MyRecipesRouterInput, interactor: MyRecipesInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
    func toViewModel(model: MyRecipe) -> RecipesViewModel {
        return RecipesViewModel(id: model.id, title: model.title, timeToCook: "", image: model.image)
    }
}

extension MyRecipesPresenter: MyRecipesModuleInput {
}

extension MyRecipesPresenter: MyRecipesViewOutput {
    func didTapAdd() {
        router.showCreateReceipt()
    }
    
    func didSelectItem(at index: Int) {
        router.showReceipt(with: recipes[index])
    }
        
    func didLoadView() {
        self.recipes = interactor.loadMyRecipes()
        self.view?.reloadData()
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

extension MyRecipesPresenter: MyRecipesInteractorOutput {
    func didLoad(recipes: [RecipesViewModel]) {
        self.recipes = recipes
        self.view?.reloadData()
    }
}

extension MyRecipesPresenter: CreateReceiptModuleOutput {
    func didSaveReceipt(with model: CreatedReceipt) {
        let addedRecipe:RecipesViewModel = interactor.addRecipe(with: model)
        self.recipes.append(addedRecipe)
        self.view?.reloadData()
    }
}


