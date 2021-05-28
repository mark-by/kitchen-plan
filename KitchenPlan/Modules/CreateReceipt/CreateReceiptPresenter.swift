import Foundation

final class CreateReceiptPresenter {
	weak var view: CreateReceiptViewInput?
    weak var moduleOutput: CreateReceiptModuleOutput?

	private let router: CreateReceiptRouterInput
	private let interactor: CreateReceiptInteractorInput
    
    private var ingredients = [String]()

    init(router: CreateReceiptRouterInput, interactor: CreateReceiptInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension CreateReceiptPresenter: CreateReceiptModuleInput {
}

extension CreateReceiptPresenter: CreateReceiptViewOutput {
    func didSaveReceipt(with model: CreatedReceipt) {
        moduleOutput?.didSaveReceipt(with: model)
    }
}

extension CreateReceiptPresenter: CreateReceiptInteractorOutput {
}
