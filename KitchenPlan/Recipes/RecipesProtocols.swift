import UIKit

protocol RecipesViewOutput: AnyObject {
    func didLoadView()
    func didScrollEnd()
    func count() -> Int
    func item(idx: Int) -> RecipesViewModel
    func didSelectItem(at index: Int)
}

protocol RecipesViewInput: AnyObject {
    func reloadData()
}

protocol RecipesInteractorInput: AnyObject {
    func loadRecipes(since: Int, limit: Int)
}

protocol RecipesRouterInput: AnyObject {
    func showReceipt(with model: RecipesViewModel)
}

protocol RecipesInteractorOutput: AnyObject {
    func didLoad(recipes: [ReceiptInfoResponse])
}
