import UIKit

protocol RecipesViewOutput: AnyObject {
    func didLoadView()
    func didScrollEnd()
    func didSearch(text: String)
    func count() -> Int
    func item(idx: Int) -> RecipesViewModel
    func didSelectItem(at index: Int)
}

protocol RecipesViewInput: AnyObject {
    func reloadData()
}

protocol RecipesInteractorInput: AnyObject {
    func loadRecipes(since: Int, limit: Int, title: String?, type: String?)
}

protocol RecipesRouterInput: AnyObject {
    func showReceipt(with model: RecipesViewModel)
}

protocol RecipesInteractorOutput: AnyObject {
    func didLoad(recipes: [ReceiptInfoResponse])
    func didReceive()
}
