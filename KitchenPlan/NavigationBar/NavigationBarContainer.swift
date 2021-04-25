import UIKit

final class NavigationBarContainer {
    let viewController: UITabBarController
    
    private init(viewController: UITabBarController) {
        self.viewController = viewController
    }
    
    class func assemble() -> NavigationBarContainer {
        let recipesContainer = RecipesContainer.assemble()
        let productsContainer = ProductsContainer.assemble()
        let profileContainer = ProfileContainer.assemble()
        
        let bar = NavigationBarViewController(recipes: recipesContainer.viewController,
                                              products: productsContainer.viewController,
                                              profile: profileContainer.viewController)
        
        return NavigationBarContainer(viewController: bar)
    }
}
