import UIKit

final class IngredientsContainer {
    let viewController: UIViewController

    private init(viewController: UIViewController) {
        self.viewController = viewController
    }

    class func assemble() -> IngredientsContainer {
        let interactor = IngredientsInteractor()
        let presenter = IngredientsPresenter(interactor: interactor)

        let ingredientsViewController = IngredientsViewController(output: presenter)
        ingredientsViewController.title = "Ингредиенты"

        interactor.output = presenter
        presenter.view = ingredientsViewController as? IngredientsViewInput

        return IngredientsContainer(viewController: UINavigationController(rootViewController: ingredientsViewController))
    }
}
