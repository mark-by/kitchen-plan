import UIKit

final class MyRecipesViewController: UIViewController {
	private let output: MyRecipesViewOutput

    init(output: MyRecipesViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        view.backgroundColor = .white
        title = "Мои ингредиенты"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(didTapAddButton))
        
        overrideNavigateBar(navigationController?.navigationBar)
	}
    
    @objc func didTapAddButton() {
        output.didTapAdd()
    }
}

extension MyRecipesViewController: MyRecipesViewInput {
}
