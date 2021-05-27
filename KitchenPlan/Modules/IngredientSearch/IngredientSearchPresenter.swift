//
//  IngredientSearchPresenter.swift
//  KitchenPlan
//
//  Created by Artem on 22.05.2021.
//  
//

import Foundation

final class IngredientSearchPresenter {
	weak var view: IngredientSearchViewInput?
    weak var moduleOutput: IngredientSearchModuleOutput?

	private let router: IngredientSearchRouterInput
	private let interactor: IngredientSearchInteractorInput

    private var ingredients = [IngredientViewModel]()

    init(router: IngredientSearchRouterInput, interactor: IngredientSearchInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension IngredientSearchPresenter: IngredientSearchViewOutput,
    IngredientSearchInteractorOutput, IngredientSearchModuleInput {
    func count() -> Int {
        ingredients.count
    }

    func item(at idx: Int) -> String {
        ingredients[idx].title
    }

    func didSelect(at idx: Int) {
        moduleOutput?.didSelectIngredient(with: ingredients[idx])
    }

    func didEnter(text: String) {
        interactor.load(text: text)
    }

    func didLoad(with data: [IngredientViewModel]) {
        ingredients = data
        view?.reloadData()
    }

    func didRecieve() {
        ingredients = []
        view?.reloadData()
    }
}
