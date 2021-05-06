//
//  IngredientViewController.swift
//  KitchenPlan
//
//  Created by Mark Bykhovets on 04.05.2021.
//  
//

import UIKit

final class IngredientViewController: UIViewController {
	private let output: IngredientViewOutput

    init(output: IngredientViewOutput) {
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

extension IngredientViewController: IngredientViewInput {
}
