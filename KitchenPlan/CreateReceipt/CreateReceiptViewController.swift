import UIKit
import PinLayout

struct Section {
    var title: String
    var cells: [UITableViewCell]
}

final class CreateReceiptViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	private let output: CreateReceiptViewOutput
    private var sections = [
        Section(title: "", cells: [CreateReceiptImageCell(), CreateReceiptTitleCell()]),
        Section(title: "Ингредиенты", cells: [CreateReceiptIngredientsCell()]),
        Section(title: "Шаги", cells: [CreateReceiptStepCell()])
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sections[indexPath.section].cells[indexPath.row]
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        table.pin.all()
    }
    
    func didTapAddIngredient() {
        sections[1].cells.append(CreateReceiptIngredientsCell())
        table.reloadData()
    }
    
    func didTapAddStep() {
        sections[2].cells.append(CreateReceiptStepCell())
        table.reloadData()
    }
}

extension CreateReceiptViewController: CreateReceiptViewInput {
    
}
