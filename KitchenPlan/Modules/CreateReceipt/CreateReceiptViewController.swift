import UIKit
import PinLayout

struct Section {
    var title: String
    var cells: [InputCell]
}

final class CreateReceiptViewController: UIViewController {
	private let output: CreateReceiptViewOutput
    private var sections = [
        Section(title: "", cells: [CreateReceiptImageCell(), CreateReceiptTitleCell(), CreateReceiptTypeCell()]),
        Section(title: "Ингредиенты", cells: [CreateReceiptTextFieldCell()]),
        Section(title: "Шаги", cells: [CreateReceiptTextFieldCell()])
    ]
    private let table = UITableView()
    
    private var lastY: CGFloat = 0

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver( self, selector: #selector(keyboardWillShow(notification:)), name:  UIResponder.keyboardWillShowNotification, object: nil )
        NotificationCenter.default.addObserver( self, selector: #selector(keyboardWillHide(notification:)), name:  UIResponder.keyboardWillHideNotification, object: nil )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let keyboardRect = keyboardSize.cgRectValue
        if view.frame.origin.y == 0 && lastY > view.frame.maxY - keyboardRect.height {
            view.frame.origin.y -= (lastY - (view.frame.maxY - keyboardRect.height))
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
    func beginEnter(at y: CGFloat) {
        lastY = y
        print("BEGIN ENTER \(y)")
//        if y > 470 {
//            view.frame.origin.y -= 120
//        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        table.pin.all()
    }
    
    @objc func didTapSave() {
        let _ = sections[0].cells[0] //image cell
        
        guard let receiptTitle = sections[0].cells[1].getData(), receiptTitle != "" else {
            showError(error: "Имя рецепта обязательно")
            return
        }
        
        guard let type = sections[0].cells[2].getData(), type != "" else {
            showError(error: "Выберите тип")
            return
        }
        
        let ingredients = getInfoList(from: sections[1].cells)
        guard ingredients.count > 0 else {
            showError(error: "Необходим хотя бы один ингредиент")
            return
        }
        
        let steps = getInfoList(from: sections[2].cells)
        guard steps.count > 0 else {
            showError(error: "Необходим хотя бы один шаг")
            return
        }
        
        let outputReceipt = CreatedReceipt(image: nil, title: receiptTitle, type: type, ingredients: ingredients, steps: steps)
        output.didSaveReceipt(with: outputReceipt)
        dismiss(animated: true, completion: nil)
    }
    
    func showError(error: String) {
        let alert = UIAlertController(title: "Недостаточно информации", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
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
    
    func getInfoList(from cells: [InputCell]) -> [String] {
        var infos = [String]()
        cells.forEach { item in
            guard let info = item.getData(), info != "" else {
                return
            }
            infos.append(info)
        }
        return infos
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
