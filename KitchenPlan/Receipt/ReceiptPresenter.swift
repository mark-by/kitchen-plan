import Foundation

final class ReceiptPresenter {
	weak var view: ReceiptViewInput?
    weak var moduleOutput: ReceiptModuleOutput?

	private let router: ReceiptRouterInput
	private let interactor: ReceiptInteractorInput

    init(router: ReceiptRouterInput, interactor: ReceiptInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ReceiptPresenter: ReceiptModuleInput {
}

extension ReceiptPresenter: ReceiptViewOutput {
}

extension ReceiptPresenter: ReceiptInteractorOutput {
    func didLoad() {
        
    }
}
