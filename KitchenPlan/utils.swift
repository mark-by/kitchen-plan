import UIKit

func overrideNavigateBar(_ navigationBar: UINavigationBar?) {
    navigationBar?.prefersLargeTitles = true
    navigationBar?.overrideUserInterfaceStyle = .light
}
