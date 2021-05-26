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
    func loadMyRecipes() -> [RecipesViewModel]
    func addRecipe(with model: CreatedReceipt) -> RecipesViewModel
    func deleteRecipe(id: Int)
}

protocol MyRecipesInteractorOutput: AnyObject {
    func didLoad(recipes: [RecipesViewModel])
    func didReceive()
}

protocol MyRecipesRouterInput: AnyObject {
    func showCreateReceipt()
    func showReceipt(with model: RecipesViewModel)
}

protocol MyRecipesRouterOutput: AnyObject {
    func showReceipt(with model: RecipesViewModel)
}

protocol MyRecipesManagerDescription: AnyObject {
    func loadMyRecipes() -> [RecipesViewModel]
    func addToMyRecipes(with model: CreatedReceipt) -> RecipesViewModel
    func deleteMyRecipe(id: Int)
    func getMyRecipe(id: Int) -> Receipt
}
