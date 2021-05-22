import UIKit

final class ProfileViewController: UIViewController {
	private let output: ProfileViewOutput
    private let tableView = UITableView()
    private let actions = [
        ProfileAction(title: "Мои ингредиенты", image: "chef"),
    ]

    init(output: ProfileViewOutput) {
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
        overrideNavigateBar(navigationController?.navigationBar)
        
        tableView.register(ProfileActionCell.self, forCellReuseIdentifier: ProfileActionCell.indentifier)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        [tableView].forEach {
            view.addSubview($0)
        }
	}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.pin.all()
    }
}

extension ProfileViewController: ProfileViewInput {
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch actions[indexPath.row].title {
        case "Мои ингредиенты":
            output.didSelectMyRecipes()
        default:
            print("fail: unknown action")
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        actions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileActionCell.indentifier, for: indexPath) as? ProfileActionCell else {
            return .init()
        }
        
        cell.configure(with: actions[indexPath.row])
        
        return cell
    }
}
