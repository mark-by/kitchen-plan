import Foundation

protocol MyRecipesModuleInput {
	var moduleOutput: MyRecipesModuleOutput? { get }
}

protocol MyRecipesModuleOutput: AnyObject {
}

protocol MyRecipesViewInput: AnyObject {
}

protocol MyRecipesViewOutput: AnyObject {
    func didTapAdd()
}

protocol MyRecipesInteractorInput: AnyObject {
}

protocol MyRecipesInteractorOutput: AnyObject {
}

protocol MyRecipesRouterInput: AnyObject {
    func showCreateReceipt()
}
