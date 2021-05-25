import UIKit

final class IngredientContainer {
    let input: IngredientModuleInput
	let viewController: UIViewController
	private(set) weak var router: IngredientRouterInput!

	class func assemble(with model: IngredientViewModel) -> IngredientContainer {
        let router = IngredientRouter()
        let interactor = IngredientInteractor()
        let presenter = IngredientPresenter(router: router, interactor: interactor)
		let viewController = IngredientViewController(output: presenter)

		presenter.view = viewController
        // TODO (a.muradyan) pass model to presenter
		interactor.output = presenter

        return IngredientContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: IngredientModuleInput, router: IngredientRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct IngredientContext {
	weak var moduleOutput: IngredientModuleOutput?
}
