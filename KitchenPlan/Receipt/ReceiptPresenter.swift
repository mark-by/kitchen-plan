import Foundation

final class ReceiptPresenter {
	weak var view: ReceiptViewInput?
    weak var moduleOutput: ReceiptModuleOutput?
    var receiptId: Int?

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
    func didLoadView() {
        guard let receiptId = self.receiptId else {
            print("No receipt id in presenter")
            return
        }
        
        self.interactor.load(receiptId: receiptId)
    }
}

extension ReceiptPresenter: ReceiptInteractorOutput {
    func didLoad(with model: Receipt) {
        self.view?.loadData(with: model)
    }
}
