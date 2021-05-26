import Foundation

final class ReceiptInteractor {
	weak var output: ReceiptInteractorOutput?
    private let manager: ReceiptManagerDescription = ReceiptManager.shared
    private let managerMyRecipes: MyRecipesManagerDescription = MyRecipesManager.shared
    var fromDB = false
}

extension ReceiptInteractor: ReceiptInteractorInput {
    func load(receiptId: Int) {
        if fromDB {
            loadFromBD(receiptId: receiptId)
        } else {
            loadFromBack(receiptId: receiptId)
        }
    }
    
    func loadFromBack(receiptId: Int) {
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
    
    func loadFromBD(receiptId: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let receipt = self?.managerMyRecipes.getMyRecipe(id: receiptId) else {
                return
            }
            self?.output?.didLoad(with: receipt)
        }
    }
}
