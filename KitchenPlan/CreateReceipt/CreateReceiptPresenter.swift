import Foundation

final class CreateReceiptPresenter {
	weak var view: CreateReceiptViewInput?
    weak var moduleOutput: CreateReceiptModuleOutput?

	private let router: CreateReceiptRouterInput
	private let interactor: CreateReceiptInteractorInput

    init(router: CreateReceiptRouterInput, interactor: CreateReceiptInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension CreateReceiptPresenter: CreateReceiptModuleInput {
}

extension CreateReceiptPresenter: CreateReceiptViewOutput {
}

extension CreateReceiptPresenter: CreateReceiptInteractorOutput {
}
