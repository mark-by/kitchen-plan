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
    func didLoadView() {
        guard let receiptId = self.receiptId else {
            print("No receipt id in presenter")
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
