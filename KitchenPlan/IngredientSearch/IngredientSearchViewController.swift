//
//  IngredientSearchViewController.swift
//  KitchenPlan
//
//  Created by Artem on 22.05.2021.
//  
//

import UIKit

final class IngredientSearchViewController: UIViewController, UISearchResultsUpdating {
	private let output: IngredientSearchViewOutput
    private let resultView = IngredientsSearchResult()
    private var searchController: UISearchController {
        let search = UISearchController(searchResultsController: resultView)
        search.searchBar.placeholder = "Поиск ингредиентов"
        search.overrideUserInterfaceStyle = .light
        search.obscuresBackgroundDuringPresentation = false
        search.searchResultsUpdater = self
        return search
    }

    init(output: IngredientSearchViewOutput) {
        self.output = output
        resultView.output = output
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()

        title = "Поиск ингредиентов"
        navigationController?.navigationBar.overrideUserInterfaceStyle = .light

        navigationItem.searchController = searchController
        view.backgroundColor = .white
	}

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        output.didEnter(text: text)
    }
}

extension IngredientSearchViewController: IngredientSearchViewInput {
    func reloadData() {
        resultView.tableView.reloadData()
    }
}
