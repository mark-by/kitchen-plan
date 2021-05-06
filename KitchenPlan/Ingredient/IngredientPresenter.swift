import Foundation

final class IngredientPresenter {
	weak var view: IngredientViewInput?
    weak var moduleOutput: IngredientModuleOutput?

	private let router: IngredientRouterInput
	private let interactor: IngredientInteractorInput

    init(router: IngredientRouterInput, interactor: IngredientInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension IngredientPresenter: IngredientModuleInput {
}

extension IngredientPresenter: IngredientViewOutput {
}

extension IngredientPresenter: IngredientInteractorOutput {
}
