import UIKit

final class ProductsContainer {
    let viewController: UIViewController
    
    private init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    class func assemble() -> ProductsContainer {
        let productViewController = ProductsViewController()
        productViewController.title = "Продукты"
        let viewController = UINavigationController(rootViewController: productViewController)
        
        return ProductsContainer(viewController: viewController)
    }
}
