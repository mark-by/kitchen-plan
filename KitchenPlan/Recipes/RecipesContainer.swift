import UIKit

final class RecipesContainer {
    let viewController: UIViewController
    
    private init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    class func assemble() -> RecipesContainer {
        let recipesPresenter = RecipesPresenter()
        let recipesViewController = RecipesViewController(output: recipesPresenter)
        recipesViewController.title = "Рецепты"

        let viewController = UINavigationController(rootViewController: recipesViewController)
        
        return RecipesContainer(viewController: viewController)
    }
}
