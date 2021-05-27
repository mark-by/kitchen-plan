import UIKit

final class ProfileRouter {
    weak var sourceViewController: UIViewController?
}

extension ProfileRouter: ProfileRouterInput {
    func showMyRecipes() {
        let container = MyRecipesContainer.assemble(with: nil)
        sourceViewController?.navigationController?.pushViewController(container.viewController, animated: true)
    }
    
    func showFavorites() {
        let container = FavoritesContainer.assemble(with: nil)
        sourceViewController?.navigationController?.pushViewController(container.viewController, animated: true)
    }
}
