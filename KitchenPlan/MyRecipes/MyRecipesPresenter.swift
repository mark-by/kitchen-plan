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
        interactor.loadMyRecipes()
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
    func didLoad(recipes: [ReceiptInfoResponse]) {
        self.recipes.append(contentsOf: recipes.map { toViewModel(model: $0)})
        self.view?.reloadData()
    }
}
