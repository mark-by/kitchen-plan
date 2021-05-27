import UIKit

protocol RecipesViewOutput: OverallRecipesViewOutput {
    func didScrollEnd()
    func didSearch(text: String)
    func didSelectType(type: String?)
    func didToggleIngredients(isActive: Bool)
    func didSelectFromMenu()
    func selected() -> (String?, Bool)
    func canFilterByIngredients() -> Bool
}

protocol RecipesViewInput: OverallRecipesViewInput {
}

protocol RecipesInteractorInput: AnyObject {
    func loadRecipes(since: Int, limit: Int, title: String?, type: String?, ingredients: [Int])
    func havingIngredients() -> [Int]
}

protocol RecipesRouterInput: AnyObject {
    func showReceipt(with model: RecipesViewModel)
}

protocol RecipesInteractorOutput: AnyObject {
    func didLoad(recipes: [ReceiptInfoResponse])
    func didReceive()
}
