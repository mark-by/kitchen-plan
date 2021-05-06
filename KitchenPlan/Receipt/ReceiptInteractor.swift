import Foundation

final class ReceiptInteractor {
	weak var output: ReceiptInteractorOutput?
    private let manager: ReceiptManagerDescription = ReceiptManager.shared
}

extension ReceiptInteractor: ReceiptInteractorInput {
    func load(receiptId: Int) {
        manager.loadReceipt(id: receiptId) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let receipt):
                    self?.output?.didLoad(with: receipt)
                case .failure(let error):
                    print("Fail to load receipt:", error)
                }
            }
        }
    }
}
