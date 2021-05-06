//
//  IngredientInteractor.swift
//  KitchenPlan
//
//  Created by Mark Bykhovets on 04.05.2021.
//  
//

import Foundation

final class IngredientInteractor {
	weak var output: IngredientInteractorOutput?
}

extension IngredientInteractor: IngredientInteractorInput {
}
