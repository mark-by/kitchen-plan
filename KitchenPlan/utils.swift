import UIKit

func overrideNavigateBar(_ navigationBar: UINavigationBar) {
    navigationBar.prefersLargeTitles = true
    navigationBar.titleTextAttributes = [
        NSAttributedString.Key.foregroundColor : UIColor.black,
    ]
    
    navigationBar.barTintColor = .white
    navigationBar.largeTitleTextAttributes = [
        NSAttributedString.Key.foregroundColor : UIColor.black
    ]
}
