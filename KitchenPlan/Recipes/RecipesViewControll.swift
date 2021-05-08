import UIKit
import PinLayout

final class RecipesViewController: UIViewController {
    private let tableView = UITableView()
    private let output: RecipesViewOutput
    private let searchContoller = UISearchController()
    private var typeButton: UIBarButtonItem?

    init(output: RecipesViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let bar = navigationController?.navigationBar {
            overrideNavigateBar(bar)
        }
        let filter = UIBarButtonItem(
            image: UIImage(systemName: "slider.horizontal.3"), style: .plain, target: self, action: #selector(didTapFilterButton))
        typeButton = UIBarButtonItem(title: "Тип", style: .plain, target: self, action: #selector(showTypeSelector))

        navigationItem.rightBarButtonItems = [filter, typeButton!]
        overrideUserInterfaceStyle = .light
        searchContoller.searchResultsUpdater = self
        searchContoller.obscuresBackgroundDuringPresentation = false
        searchContoller.searchBar.placeholder = "Поиск рецептов"
        searchContoller.overrideUserInterfaceStyle = .light
        navigationItem.searchController = searchContoller
                
        view.backgroundColor = .white
        
        tableView.register(RecipesTableViewCell.self, forCellReuseIdentifier: "RecipesTableViewCell")
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none

        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)
        output.didLoadView()
    }
    
    @objc func showTypeSelector() {
        let typePicker = TypePicker()
        typePicker.output = output
        typePicker.mainViewController = self
        present(typePicker, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.pin.all()
    }
    
    @objc func didTapFilterButton() {
        
    }
}

extension RecipesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.count()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesTableViewCell", for: indexPath) as? RecipesTableViewCell else {
            return .init()
        }
        
        let viewModel = output.item(idx: indexPath.row)
        cell.configure(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didSelectItem(at: indexPath.row)
    }
}

extension RecipesViewController: RecipesViewInput {
    func reloadData() {
        self.tableView.refreshControl?.endRefreshing()
        self.tableView.reloadData()
    }
}

extension RecipesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > tableView.contentSize.height - 100 - scrollView.frame.size.height && tableView.contentSize.height != 0 {
            output.didScrollEnd()
        }
    }
}

extension RecipesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        output.didSearch(text: text)
    }
}
