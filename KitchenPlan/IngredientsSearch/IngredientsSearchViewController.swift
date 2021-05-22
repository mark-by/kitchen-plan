//
//  IngredientsSearchViewController.swift
//  KitchenPlan
//
//  Created by Artem on 22.05.2021.
//  
//

import UIKit

final class IngredientsSearchViewController: UIViewController {
	private let output: IngredientsSearchViewOutput

    init(output: IngredientsSearchViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension IngredientsSearchViewController: IngredientsSearchViewInput {
}
