import UIKit
import PinLayout

final class RecipesViewController: UIViewController {
    private let tableView = UITableView()
    private let output: RecipesViewOutput

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
        
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none

        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.pin.all()
    }
}

extension RecipesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.count()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = output.item(idx: indexPath.row)
        let cell = RecipesTableViewCell()
        cell.configure(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = output.item(idx: indexPath.row)
        let viewController = UIViewController()
        viewController.title = city.title
        viewController.view.backgroundColor = .white
            
        let navigationController = UINavigationController(rootViewController: viewController)
            
        present(navigationController, animated: true, completion: nil)
    }
}
