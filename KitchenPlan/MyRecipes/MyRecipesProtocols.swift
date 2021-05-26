import Foundation

protocol MyRecipesModuleInput {
    var moduleOutput: MyRecipesModuleOutput? { get }
}

protocol MyRecipesModuleOutput: AnyObject {
}

protocol MyRecipesViewInput: AnyObject {
    func reloadData()
}

protocol MyRecipesViewOutput: AnyObject {
    func didTapAdd()
    func didLoadView()
    func count() -> Int
    func item(idx: Int) -> RecipesViewModel
    func didSelectItem(at index: Int)
}

protocol MyRecipesInteractorInput: AnyObject {
    func loadMyRecipes()
}

protocol MyRecipesInteractorOutput: AnyObject {
    func didLoad(recipes: [ReceiptInfoResponse])
    func didReceive()
}

protocol MyRecipesRouterInput: AnyObject {
    func showCreateReceipt()
    func showReceipt(with model: RecipesViewModel)
}

protocol MyRecipesRouterOutput: AnyObject {
    func showReceipt(with model: RecipesViewModel)
}
