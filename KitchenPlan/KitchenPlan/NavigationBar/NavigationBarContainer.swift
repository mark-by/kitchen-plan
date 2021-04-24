import UIKit

final class NavigationBarContainer {
    let viewController: UITabBarController
    
    private init(viewController: UITabBarController) {
        self.viewController = viewController
    }
    
    class func assemble() -> NavigationBarContainer {
        let bar = NavigationBarViewController()
        
        let recipesContainer = RecipesContainer.assemble()
        let productsContainer = ProductsContainer.assemble()
        let profileContainer = ProfileContainer.assemble()
        
        bar.setViewControllers([recipesContainer.viewController,
                                productsContainer.viewController,
                                profileContainer.viewController],
                               animated: true)
        
        guard let items = bar.tabBar.items else {
            return NavigationBarContainer(viewController: bar)
        }
        
        let images = ["house", "bell", "person.circle"]
        
        for idx in 0..<items.count {
            items[idx].image = UIImage(systemName: images[idx])
        }
        
        return NavigationBarContainer(viewController: bar)
    }
}
