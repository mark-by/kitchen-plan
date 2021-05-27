import UIKit

final class FavoritesViewController: BaseRecipesViewController {
	private let finalOutput: FavoritesViewOutput
    private let refreshControl = UIRefreshControl()


    init(output: FavoritesViewOutput) {
        finalOutput = output
        
        super.init(output: output)
        
        delegate = self
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
        title = "Избранное"
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
		super.viewDidLoad()
	}
    
    @objc func refresh() {
        output.didLoadView()
    }
}

extension FavoritesViewController: FavoritesViewInput {
}

extension FavoritesViewController: BaseRecipesDelgate {
    func setImage(view: UIImageView, with source: String) {
        view.kf.setImage(
            with: URL(string: source),
            placeholder: UIImage(named: "receptPlaceholder"))
    }
}

extension FavoritesViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > tableView.contentSize.height - 100 - scrollView.frame.size.height && tableView.contentSize.height != 0 {
            finalOutput.didScrollEnd()
        }
    }
}
