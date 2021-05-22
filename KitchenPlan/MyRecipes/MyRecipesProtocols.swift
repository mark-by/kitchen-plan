import Foundation

protocol MyRecipesModuleInput {
	var moduleOutput: MyRecipesModuleOutput? { get }
}

protocol MyRecipesModuleOutput: class {
}

protocol MyRecipesViewInput: class {
}

protocol MyRecipesViewOutput: class {
}

protocol MyRecipesInteractorInput: class {
}

protocol MyRecipesInteractorOutput: class {
}

protocol MyRecipesRouterInput: class {
}
