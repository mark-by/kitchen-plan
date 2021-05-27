import UIKit

final class MyRecipesViewController: BaseRecipesViewController {
    private let finalOutput: MyRecipesViewOutput
    private var addButton: UIBarButtonItem?

    init(output: MyRecipesViewOutput) {
        finalOutput = output

        super.init(output: output)
        
        dataSource = self
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        title = "Мои рецепты"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(didTapAddButton))
        
        super.viewDidLoad()
    }
    
    @objc func didTapAddButton() {
        finalOutput.didTapAdd()
    }
}

extension MyRecipesViewController: BaseRecipesDelgate {
    func setImage(view: UIImageView, with source: String) {
        view.image = UIImage(named: "receptPlaceholder")
    }
}

extension MyRecipesViewController: MyRecipesViewInput {
    
}
