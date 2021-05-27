import UIKit
import PinLayout

protocol BaseRecipesDelgate: AnyObject {
    func setImage(view: UIImageView, with source: String)
}

protocol BaseRecipesViewOutput: AnyObject {
    func didLoadView()
    func count() -> Int
    func item(idx: Int) -> RecipesViewModel
    func didSelectItem(at index: Int)
}

protocol BaseRecipesViewInput: AnyObject {
    func reloadData()
}

class BaseRecipesViewController: UIViewController {
    internal let tableView = UITableView()
    internal let output: BaseRecipesViewOutput
    internal var delegate: BaseRecipesDelgate?

    init(output: BaseRecipesViewOutput) {
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

extension BaseRecipesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.count()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesTableViewCell", for: indexPath) as? RecipesTableViewCell else {
            return .init()
        }
        
        let viewModel = output.item(idx: indexPath.row)
        cell.configure(with: viewModel, setImage: {imageView, imageUrl in
            delegate?.setImage(view: imageView, with: imageUrl)
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

extension BaseRecipesViewController: BaseRecipesViewInput {
    func reloadData() {
        self.tableView.refreshControl?.endRefreshing()
        self.tableView.reloadData()
    }
}
