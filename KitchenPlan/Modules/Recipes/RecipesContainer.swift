import UIKit

final class RecipesContainer {
    let viewController: UIViewController
    
    private init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    class func assemble() -> RecipesContainer {
        let interactor = RecipesInteractor()
        let router = RecipesRouter()
        let presenter = RecipesPresenter(interactor: interactor, router: router)
        
        let recipesViewController = RecipesViewController(output: presenter)
        let userDefaults = UserDefaults()
        if let type = userDefaults.string(forKey: "receipt_type") {
            recipesViewController.title = type
        } else {
            recipesViewController.title = "Рецепты"
        }
        
        router.sourceViewController = recipesViewController
        interactor.output = presenter
        presenter.view = recipesViewController
        
        return RecipesContainer(viewController: recipesViewController)
    }
}
