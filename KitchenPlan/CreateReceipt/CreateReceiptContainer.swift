import UIKit

final class CreateReceiptContainer {
    let input: CreateReceiptModuleInput
	let viewController: UIViewController
	private(set) weak var router: CreateReceiptRouterInput!

	class func assemble(with context: CreateReceiptContext?) -> CreateReceiptContainer {
        let router = CreateReceiptRouter()
        let interactor = CreateReceiptInteractor()
        let presenter = CreateReceiptPresenter(router: router, interactor: interactor)
		let viewController = CreateReceiptViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context?.moduleOutput

		interactor.output = presenter

        return CreateReceiptContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: CreateReceiptModuleInput, router: CreateReceiptRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct CreateReceiptContext {
	weak var moduleOutput: CreateReceiptModuleOutput?
}
