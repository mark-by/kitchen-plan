//
//  IngredientSearchContainer.swift
//  KitchenPlan
//
//  Created by Artem on 22.05.2021.
//  
//

import UIKit

final class IngredientSearchContainer {
    let input: IngredientSearchModuleInput
	let viewController: UIViewController
	private(set) weak var router: IngredientSearchRouterInput!

	class func assemble(with context: IngredientSearchContext) -> IngredientSearchContainer {
        let router = IngredientSearchRouter()
        let interactor = IngredientSearchInteractor()
        let presenter = IngredientSearchPresenter(router: router, interactor: interactor)
		let viewController = IngredientSearchViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter
        return IngredientSearchContainer(
            view: UINavigationController(rootViewController: viewController),
            input: presenter,
            router: router
        )
	}

    private init(view: UIViewController, input: IngredientSearchModuleInput, router: IngredientSearchRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct IngredientSearchContext {
	weak var moduleOutput: IngredientSearchModuleOutput?
}
