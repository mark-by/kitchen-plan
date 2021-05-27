//
//  IngredientsRouter.swift
//  KitchenPlan
//
//  Created by Artem on 22.05.2021.
//

import Foundation

import UIKit

final class IngredientsRouter {
    weak var sourceViewController: UIViewController?
    weak var searchOutput: IngredientSearchModuleOutput?
}

extension IngredientsRouter: IngredientsRouterInput {
    func showIngredient(with model: IngredientViewModel) {
        let ingredientContainer = IngredientContainer.assemble(with: model)

        sourceViewController?.present(ingredientContainer.viewController, animated: true, completion: nil)
    }

    func showIngredientSearch() {
        let container = IngredientSearchContainer.assemble(with: IngredientSearchContext(moduleOutput: searchOutput))

        sourceViewController?.present(container.viewController, animated: true, completion: nil)
    }
}
