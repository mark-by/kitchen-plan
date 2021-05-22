import Foundation

final class MyRecipesPresenter {
	weak var view: MyRecipesViewInput?
    weak var moduleOutput: MyRecipesModuleOutput?

	private let router: MyRecipesRouterInput
	private let interactor: MyRecipesInteractorInput

    init(router: MyRecipesRouterInput, interactor: MyRecipesInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MyRecipesPresenter: MyRecipesModuleInput {
}

extension MyRecipesPresenter: MyRecipesViewOutput {
    func didTapAdd() {
        router.showCreateReceipt()
    }
}

extension MyRecipesPresenter: MyRecipesInteractorOutput {
}
