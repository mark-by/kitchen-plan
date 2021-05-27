import UIKit
import PinLayout

final class RecipesViewController: OverallRecipesViewController {
    private let searchContoller = UISearchController()
    private let finalOutput: RecipesViewOutput
    
    init(output: RecipesViewOutput) {
        finalOutput = output

        super.init(output: output)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        dataSource = self

        let filter = UIBarButtonItem(
            image: UIImage(systemName: "slider.horizontal.3"), style: .plain, target: self, action: #selector(didTapFilterButton))

        navigationItem.rightBarButtonItem = filter
        searchContoller.searchResultsUpdater = self
        searchContoller.obscuresBackgroundDuringPresentation = false
        searchContoller.searchBar.placeholder = "Поиск рецептов"
        searchContoller.overrideUserInterfaceStyle = .light
        navigationItem.searchController = searchContoller
                
        view.backgroundColor = .white

        view.addSubview(tableView)
        super.viewDidLoad()
    }

    func didSelectFromMenu() {
        finalOutput.didSelectFromMenu()
    }
    
    @objc func didTapFilterButton() {
        let typePicker = TypePicker()
        typePicker.output = finalOutput
        typePicker.mainViewController = self
        present(typePicker, animated: true, completion: nil)
    }
}

extension RecipesViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > tableView.contentSize.height - 100 - scrollView.frame.size.height && tableView.contentSize.height != 0 {
            finalOutput.didScrollEnd()
        }
    }
}

extension RecipesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        finalOutput.didSearch(text: text)
    }
}

extension RecipesViewController: OverallRecipesDataSource {
    func setImage(view: UIImageView, with source: String) {
        view.kf.setImage(
            with: URL(string: source),
            placeholder: UIImage(named: "receptPlaceholder"))
    }
}

extension RecipesViewController: RecipesViewInput {
    
}
