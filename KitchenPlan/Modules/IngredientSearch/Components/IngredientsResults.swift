//
//  IngredientsResults.swift
//  KitchenPlan
//
//  Created by Artem on 23.05.2021.
//

import UIKit
import PinLayout

final class IngredientsSearchResult: UIViewController {
    let tableView = UITableView()
    var output: IngredientSearchViewOutput?

    override func viewDidLoad() {
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)
    }

    override func viewDidLayoutSubviews() {
        tableView.pin.all()
    }
}

extension IngredientsSearchResult: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.didSelect(at: indexPath.row)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output!.count()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = output!.item(at: indexPath.row)
        return cell
    }
}
