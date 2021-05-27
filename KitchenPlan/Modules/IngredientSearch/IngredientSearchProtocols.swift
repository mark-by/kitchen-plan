//
//  IngredientSearchProtocols.swift
//  KitchenPlan
//
//  Created by Artem on 22.05.2021.
//  
//

import Foundation

protocol IngredientSearchModuleInput {
	var moduleOutput: IngredientSearchModuleOutput? { get }
}

protocol IngredientSearchModuleOutput: AnyObject {
    func didSelectIngredient(with model: IngredientViewModel)
}

protocol IngredientSearchViewInput: AnyObject {
    func reloadData()
}

protocol IngredientSearchViewOutput: AnyObject {
    func count() -> Int
    func item(at idx: Int) -> String
    func didSelect(at idx: Int)
    func didEnter(text: String)
}

protocol IngredientSearchInteractorInput: AnyObject {
    func load(text: String)
}

protocol IngredientSearchInteractorOutput: AnyObject {
    func didLoad(with data: [IngredientViewModel])
    func didRecieve()
}

protocol IngredientSearchRouterInput: AnyObject {}
