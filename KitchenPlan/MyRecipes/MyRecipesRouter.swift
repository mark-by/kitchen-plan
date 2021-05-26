import UIKit

final class MyRecipesRouter {
    weak var sourceViewController: UIViewController?
    weak var moduleOutput: CreateReceiptModuleOutput?
}

extension MyRecipesRouter: MyRecipesRouterInput {
    func showReceipt(with model: RecipesViewModel) {
        print(#function)
    }
    
    func showCreateReceipt() {
        let container = CreateReceiptContainer.assemble(with: CreateReceiptContext(moduleOutput: moduleOutput))
        
        sourceViewController?.present(container.viewController, animated: true, completion: nil)
    }
}
