import UIKit

final class ProfileContainer {
    let viewController: UIViewController
    
    private init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    class func assemble() -> ProfileContainer {
        let profileViewController = ProfileViewController()
        profileViewController.title = "Профиль"
        let viewController = UINavigationController(rootViewController: profileViewController)
        
        return ProfileContainer(viewController: viewController)
    }
}
