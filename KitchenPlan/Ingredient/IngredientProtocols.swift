import Foundation

protocol IngredientModuleInput {
	var moduleOutput: IngredientModuleOutput? { get }
}

protocol IngredientModuleOutput: AnyObject {
}

protocol IngredientViewInput: AnyObject {
}

protocol IngredientViewOutput: AnyObject {
}

protocol IngredientInteractorInput: AnyObject {
}

protocol IngredientInteractorOutput: AnyObject {
}

protocol IngredientRouterInput: AnyObject {
}
