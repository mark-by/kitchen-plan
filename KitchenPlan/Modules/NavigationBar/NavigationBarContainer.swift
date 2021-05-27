import UIKit

final class NavigationBarContainer {
    let viewController: UITabBarController
    
    private init(viewController: UITabBarController) {
        self.viewController = viewController
    }
    
    class func assemble() -> NavigationBarContainer {
        let recipesContainer = RecipesContainer.assemble()
        let ingredeitnsContainer = IngredientsContainer.assemble()
        let profileContainer = ProfileContainer.assemble()
        
        let bar = NavigationBarViewController(recipes: UINavigationController(rootViewController: recipesContainer.viewController),
                                              products: UINavigationController(rootViewController: ingredeitnsContainer.viewController),
                                              profile: UINavigationController(rootViewController: profileContainer.viewController))
        
        return NavigationBarContainer(viewController: bar)
    }
}
