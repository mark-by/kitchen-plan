import Foundation

protocol FavoritesModuleInput {
	var moduleOutput: FavoritesModuleOutput? { get }
}

protocol FavoritesModuleOutput: AnyObject {
}

protocol FavoritesViewInput: BaseRecipesViewInput {
}

protocol FavoritesViewOutput: BaseRecipesViewOutput {
    func didScrollEnd()
    func didDelete(at idx: Int)
}

protocol FavoritesInteractorInput: AnyObject {
    func loadRecipes(since: Int, recipes: [Int])

}

protocol FavoritesInteractorOutput: AnyObject {
    func didLoad(recipes: [ReceiptInfoResponse])
    func didReceive()
}

protocol FavoritesRouterInput: AnyObject {
    func showReceipt(with model: RecipesViewModel)
}
