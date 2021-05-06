import UIKit

protocol RecipesViewOutput: AnyObject {
    func didLoadView()
    func count() -> Int
    func item(idx: Int) -> RecipesViewModel
    func didSelectItem(at index: Int)
}

protocol RecipesViewInput: AnyObject {
    func reloadData()
}

protocol RecipesInteractorInput: AnyObject {
    func loadRecipes()
}

protocol RecipesRouterInput: AnyObject {
    func showReceipt(with model: RecipesViewModel)
}

protocol RecipesInteractorOutput: AnyObject {
    func didLoad(recipes: [ReceiptInfoResponse])
}
