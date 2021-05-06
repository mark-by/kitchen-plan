//
//  IngredientProtocols.swift
//  KitchenPlan
//
//  Created by Mark Bykhovets on 04.05.2021.
//  
//

import Foundation

protocol IngredientModuleInput {
	var moduleOutput: IngredientModuleOutput? { get }
}

protocol IngredientModuleOutput: class {
}

protocol IngredientViewInput: class {
}

protocol IngredientViewOutput: class {
}

protocol IngredientInteractorInput: class {
}

protocol IngredientInteractorOutput: class {
}

protocol IngredientRouterInput: class {
}
