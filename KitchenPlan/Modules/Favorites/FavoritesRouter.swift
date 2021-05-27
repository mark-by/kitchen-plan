import UIKit

final class FavoritesRouter {
    weak var sourceViewController: UIViewController?
}

extension FavoritesRouter: FavoritesRouterInput {
    func showReceipt(with model: RecipesViewModel) {
        let receiptContainer = ReceiptContainer.assemble(with: model)
            
        sourceViewController?.present(receiptContainer.viewController, animated: true, completion: nil)
    }
}
