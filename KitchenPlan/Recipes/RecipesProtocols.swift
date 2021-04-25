import UIKit

protocol RecipesViewOutput: AnyObject {
    func didLoadView()
    func count() -> Int
    func item(idx: Int) -> RecipesViewModel
}
