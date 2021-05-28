import Foundation

final class ReceiptPresenter {
	weak var view: ReceiptViewInput?
    weak var moduleOutput: ReceiptModuleOutput?
    
    var receiptId: Int?
    private var receipt: ReceiptModelView?

	private let router: ReceiptRouterInput
	private let interactor: ReceiptInteractorInput

    init(router: ReceiptRouterInput, interactor: ReceiptInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
    func toView(from model: Receipt) -> ReceiptModelView {
        return ReceiptModelView(
            type: model.type.lowercased(),
            steps: model.steps,
            ingredients: ingredientsToStr(model.ingredients))
    }
    
    func ingredientsToStr(_ ingredients: [IngredientViewModel]) -> [String] {
        return ingredients.map { (item) in
            var text = "\(item.title)"
            if let quantity = item.quantity, let measure = item.measure {
                text += " \(quantity) \(measure)"
            }
            return text
        }
    }
}

extension ReceiptPresenter: ReceiptModuleInput {
}

extension ReceiptPresenter: ReceiptViewOutput {
    func isFavorite() -> Bool {
        guard let receiptId = receiptId, let favorites = UserDefaults.standard.array(forKey: "favorites") as? [Int], let _ = favorites.firstIndex(of: receiptId) else {
            return false
        }
        return true
    }
    
    func didTapHeart() {
        guard let receiptId = receiptId else {
            return
        }
        guard var favorites = UserDefaults.standard.array(forKey: "favorites") as? [Int] else {
            UserDefaults.standard.setValue([receiptId], forKey: "favorites")
            return
        }
        if let _ = favorites.firstIndex(of: receiptId) {
            UserDefaults.standard.setValue(favorites.filter { item in
                item != receiptId
            }, forKey: "favorites")
        } else {
            favorites.append(receiptId)
            UserDefaults.standard.setValue(favorites, forKey: "favorites")
        }
    }
    
    func didLoadView() {
        guard let receiptId = self.receiptId else {
            return
        }
        
        self.interactor.load(receiptId: receiptId)
    }
    
    func getModel() -> ReceiptModelView? {
        return receipt
    }
}

extension ReceiptPresenter: ReceiptInteractorOutput {
    func didLoad(with model: Receipt) {
        self.receipt = toView(from: model)
        self.view?.loadData(with: model)
    }
}
