import UIKit

final class MyRecipesContainer {
    let input: MyRecipesModuleInput
	let viewController: UIViewController
	private(set) weak var router: MyRecipesRouterInput!

	class func assemble(with context: MyRecipesContext?) -> MyRecipesContainer {
        let router = MyRecipesRouter()
        let interactor = MyRecipesInteractor()
        let presenter = MyRecipesPresenter(router: router, interactor: interactor)
		let viewController = MyRecipesViewController(output: presenter)

		presenter.view = viewController
        presenter.moduleOutput = context?.moduleOutput

		interactor.output = presenter

        return MyRecipesContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: MyRecipesModuleInput, router: MyRecipesRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct MyRecipesContext {
	weak var moduleOutput: MyRecipesModuleOutput?
}
