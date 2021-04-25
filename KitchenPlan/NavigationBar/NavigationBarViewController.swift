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
        tabBar.isTranslucent = false
        tabBar.barTintColor = .white
        tabBar.tintColor = .black
//        tabBar.unselectedItemTintColor
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowRadius = 2
        tabBar.layer.shadowOpacity = 0.1
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
