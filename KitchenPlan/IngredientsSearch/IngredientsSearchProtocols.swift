//
//  IngredientsSearchProtocols.swift
//  KitchenPlan
//
//  Created by Artem on 22.05.2021.
//  
//

import Foundation

protocol IngredientsSearchModuleInput {
	var moduleOutput: IngredientsSearchModuleOutput? { get }
}

protocol IngredientsSearchModuleOutput: class {
}

protocol IngredientsSearchViewInput: class {
}

protocol IngredientsSearchViewOutput: class {
}

protocol IngredientsSearchInteractorInput: class {
}

protocol IngredientsSearchInteractorOutput: class {
}

protocol IngredientsSearchRouterInput: class {
}
