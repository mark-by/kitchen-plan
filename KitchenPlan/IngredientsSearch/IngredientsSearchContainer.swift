//
//  IngredientsSearchContainer.swift
//  KitchenPlan
//
//  Created by Artem on 22.05.2021.
//  
//

import UIKit

final class IngredientsSearchContainer {
    let input: IngredientsSearchModuleInput
	let viewController: UIViewController
	private(set) weak var router: IngredientsSearchRouterInput!

	class func assemble(with context: IngredientsSearchContext) -> IngredientsSearchContainer {
        let router = IngredientsSearchRouter()
        let interactor = IngredientsSearchInteractor()
        let presenter = IngredientsSearchPresenter(router: router, interactor: interactor)
		let viewController = IngredientsSearchViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return IngredientsSearchContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: IngredientsSearchModuleInput, router: IngredientsSearchRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct IngredientsSearchContext {
	weak var moduleOutput: IngredientsSearchModuleOutput?
}
