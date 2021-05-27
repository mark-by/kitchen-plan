import UIKit

final class IngredientsContainer {
    let viewController: UIViewController
    let input: IngredientsModuleInput
    private(set) weak var router: IngredientsRouter!

    private init(view: UIViewController, input: IngredientsModuleInput, router: IngredientsRouter) {
        self.viewController = view
        self.input = input
        self.router = router
    }

    class func assemble() -> IngredientsContainer {
        let interactor = IngredientsInteractor()
        let router = IngredientsRouter()
        let presenter = IngredientsPresenter(router: router, interactor: interactor)

        let ingredientsViewController = IngredientsViewController(output: presenter)
        ingredientsViewController.title = "Ингредиенты"

        router.sourceViewController = ingredientsViewController
        router.searchOutput = presenter
        
        interactor.output = presenter
        presenter.view = ingredientsViewController

        return IngredientsContainer(view: ingredientsViewController, input: presenter, router: router)
    }
}
