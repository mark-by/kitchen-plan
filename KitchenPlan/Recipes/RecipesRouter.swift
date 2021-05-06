import UIKit

final class RecipesRouter {
    weak var sourceViewController: UIViewController?
}

extension RecipesRouter: RecipesRouterInput {
    func showReceipt(with model: RecipesViewModel) {
        let receiptContainer = ReceiptContainer.assemble(with: model)
            
        sourceViewController?.present(receiptContainer.viewController, animated: true, completion: nil)
    }
}
