import UIKit

final class NavigationBarViewController: UITabBarController {
    private var recipesController: UIViewController
    private var productsController: UIViewController
    private var profileController: UIViewController
    
    init(recipes: UIViewController, products: UIViewController, profile: UIViewController) {
        self.recipesController = recipes
        self.productsController = products
        self.profileController = profile
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        tabBar.isTranslucent = false
        tabBar.barTintColor = .white
        tabBar.tintColor = .black
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowRadius = 2
        tabBar.layer.shadowOpacity = 0.05
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -3)
        tabBar.backgroundColor = .white
        setViewControllers([recipesController, productsController, profileController], animated: true)
        guard let items = tabBar.items else {
            return
        }
        
        let images = ["chef", "fridge", "profile"]
        
        for idx in 0..<items.count {
            items[idx].image = UIImage(named: images[idx])
        }
    }
}

extension NavigationBarViewController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let title = item.title else {
            return
        }
        
        guard let _ = ["Рецепты", "Завтраки", "Ужины","Обеды","Десерты"].firstIndex(of: title) else {
            return
        }
        
        guard let recipesController = viewControllers?[0] as? UINavigationController else {
            return
        }
        
        guard let recipesView = recipesController.viewControllers[0] as? RecipesViewController else {
            return
        }
        
        recipesView.didSelectFromMenu()
    }
}
