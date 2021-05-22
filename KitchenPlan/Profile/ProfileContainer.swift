import UIKit

final class ProfileContainer {
    let input: ProfileModuleInput
	let viewController: UIViewController
	private(set) weak var router: ProfileRouterInput!

	class func assemble() -> ProfileContainer {
        let router = ProfileRouter()
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter(router: router, interactor: interactor)
		let viewController = ProfileViewController(output: presenter)

        viewController.title = "Профиль"
		presenter.view = viewController

		interactor.output = presenter
                
        router.sourceViewController = viewController

        return ProfileContainer(view: UINavigationController(rootViewController: viewController), input: presenter, router: router)
	}

    private init(view: UIViewController, input: ProfileModuleInput, router: ProfileRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct ProfileContext {
	weak var moduleOutput: ProfileModuleOutput?
}
