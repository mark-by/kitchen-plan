//
//  IngredientsSearchPresenter.swift
//  KitchenPlan
//
//  Created by Artem on 22.05.2021.
//  
//

import Foundation

final class IngredientsSearchPresenter {
	weak var view: IngredientsSearchViewInput?
    weak var moduleOutput: IngredientsSearchModuleOutput?

	private let router: IngredientsSearchRouterInput
	private let interactor: IngredientsSearchInteractorInput

    init(router: IngredientsSearchRouterInput, interactor: IngredientsSearchInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension IngredientsSearchPresenter: IngredientsSearchModuleInput {
}

extension IngredientsSearchPresenter: IngredientsSearchViewOutput {
}

extension IngredientsSearchPresenter: IngredientsSearchInteractorOutput {
}
