import UIKit

final class ReceiptContainer {
    let input: ReceiptModuleInput
	let viewController: UIViewController
	private(set) weak var router: ReceiptRouterInput!

    class func assemble(with model: RecipesViewModel) -> ReceiptContainer {
        let router = ReceiptRouter()
        let interactor = ReceiptInteractor()
        let presenter = ReceiptPresenter(router: router, interactor: interactor)
		let viewController = ReceiptViewController(output: presenter, model: model)

		presenter.view = viewController
        presenter.receiptId = model.id
		interactor.output = presenter

        return ReceiptContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: ReceiptModuleInput, router: ReceiptRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct ReceiptContext {
	weak var moduleOutput: ReceiptModuleOutput?
}
