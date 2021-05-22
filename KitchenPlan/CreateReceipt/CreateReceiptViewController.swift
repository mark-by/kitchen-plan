import UIKit
import PinLayout

struct Section {
    var title: String
    var cells: [UITableViewCell]
}

final class CreateReceiptViewController: UIViewController {
	private let output: CreateReceiptViewOutput
    private var sections = [
        Section(title: "", cells: [CreateReceiptImageCell(), CreateReceiptTitleCell()]),
        Section(title: "Ингредиенты", cells: [CreateReceiptTextFieldCell()]),
        Section(title: "Шаги", cells: [CreateReceiptTextFieldCell()])
    ]
    private let table = UITableView()

    init(output: CreateReceiptViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        
        title = "Создание рецепта"
        
        table.backgroundColor = .white
        table.separatorStyle = .none
        table.overrideUserInterfaceStyle = .light
        
        overrideNavigateBar(navigationController?.navigationBar)
        
        let tableHeaderHeight = CGFloat(40)
        let tableWidth = self.table.bounds.size.width
        let tableFrame = CGRect(x: 0, y: 0, width: tableWidth , height: tableHeaderHeight)
        self.table.tableHeaderView = UIView(frame: tableFrame)
        table.contentInset = UIEdgeInsets(top: -tableHeaderHeight, left: 0, bottom: 0, right: 0)
        
        table.delegate = self
        table.dataSource = self
        
        view.backgroundColor = .white
        
        [table].forEach {
            view.addSubview($0)
        }
	}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        table.pin.all()
    }
    
    func didTapButton(section: Int, row: Int) {
        let cell = CreateReceiptTextFieldCell()
        cell.setMinusImage()
        sections[section].cells.append(cell)
        table.reloadData()
    }
}

extension CreateReceiptViewController: CreateReceiptViewInput {
    
}

extension CreateReceiptViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sections[indexPath.section].cells[indexPath.row]
        if indexPath.section == 0 {
            return cell
        }
        
        guard let cell = cell as? CreateReceiptTextFieldCell else {
            return .init()
        }
        
        if indexPath.section == 1 {
            cell.configure(output: self, title: "ингредиент", section: indexPath.section, row: indexPath.row)
        } else {
            cell.configure(output: self, title: "шаг", section: indexPath.section, row: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].title
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        30
    }
}

extension CreateReceiptViewController: UITableViewDelegate {
    
}
