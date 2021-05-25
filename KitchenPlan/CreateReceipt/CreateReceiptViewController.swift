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
        
        navigationController?.navigationBar.overrideUserInterfaceStyle = .light
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapSave))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapClose))
        
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
    
    @objc func didTapSave() {
        let receiptName = sections[0].title
        
        let ingredients = getIngredients()
        
        print(receiptName)
        print("\nINGREDIENTS: \(ingredients)")
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    func didTapButton(section: Int, row: Int) {
        if row == 0 {
            let cell = CreateReceiptTextFieldCell()
            cell.setMinusImage()
            sections[section].cells.append(cell)
            table.reloadData()
            return
        }
        
        sections[section].cells.remove(at: row)
        table.reloadData()
    }
    
    func getIngredients() -> [Ingredient] {
        print("ENTER")
        var ingredients = [Ingredient]()
        for ingredientName in sections[1].cells {
            
            // fuck this shit!!!!!!
            print("INGREDIENT CELL: \(String(describing: ingredientName.textLabel?.text))")
            
            guard let title = ingredientName.textLabel?.text else {
                return ingredients
            }
            let ingredient = Ingredient(id: 0, title: title, image: "", measure: "", quantity: 0.00)
            
            print("INGREDIENT FROM FUNC: \(ingredient)")
            
            ingredients.append(ingredient)
        }
        
        print("\nINGREDIENTS FROM FUNC: \(ingredients)")
        
        return ingredients
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        
        let headerView = UIView()
        headerView.pin.all()
        headerView.backgroundColor = .white
        
        let label = UILabel()
        label.text = sections[section].title
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        label.pin.left(10).top(10).vCenter().height(20).sizeToFit(.content)

        headerView.addSubview(label)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sections[indexPath.section].cells[indexPath.row]
        if indexPath.section == 0 {
            return cell
        }

        guard let textCell = cell as? CreateReceiptTextFieldCell else {
            return .init()
        }

        if indexPath.section == 1 {
            textCell.configure(output: self, title: "ингредиент", section: indexPath.section, row: indexPath.row)
        } else {
            textCell.configure(output: self, title: "шаг", section: indexPath.section, row: indexPath.row)
        }
        return textCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].title
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}

extension CreateReceiptViewController: UITableViewDelegate {
    
}
