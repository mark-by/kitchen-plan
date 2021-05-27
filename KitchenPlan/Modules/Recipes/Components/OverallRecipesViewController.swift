import UIKit
import PinLayout

protocol OverallRecipesDataSource: AnyObject {
    func setImage(view: UIImageView, with source: String)
}

protocol OverallRecipesViewOutput: AnyObject {
    func didLoadView()
    func count() -> Int
    func item(idx: Int) -> RecipesViewModel
    func didSelectItem(at index: Int)
}

protocol OverallRecipesViewInput: AnyObject {
    func reloadData()
}

class OverallRecipesViewController: UIViewController {
    internal let tableView = UITableView()
    internal let output: OverallRecipesViewOutput
    internal var dataSource: OverallRecipesDataSource?

    init(output: OverallRecipesViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideNavigateBar(navigationController?.navigationBar)
        view.backgroundColor = .white
        
        tableView.register(RecipesTableViewCell.self, forCellReuseIdentifier: "RecipesTableViewCell")
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none

        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)
        output.didLoadView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.pin.all()
    }
}

extension OverallRecipesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.count()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesTableViewCell", for: indexPath) as? RecipesTableViewCell else {
            return .init()
        }
        
        let viewModel = output.item(idx: indexPath.row)
        cell.configure(with: viewModel, setImage: {imageView, imageUrl in
            dataSource?.setImage(view: imageView, with: imageUrl)
        })

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

extension OverallRecipesViewController: OverallRecipesViewInput {
    func reloadData() {
        self.tableView.refreshControl?.endRefreshing()
        self.tableView.reloadData()
    }
}
