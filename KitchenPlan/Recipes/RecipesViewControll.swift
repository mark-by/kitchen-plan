import UIKit
import PinLayout

final class RecipesViewController: UIViewController {
    private let tableView = UITableView()
//    private let output: RecipesViewOutput
//
//    init(output: RecipesViewOutput) {
//        self.output = output
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let bar = navigationController?.navigationBar {
            overrideNavigateBar(bar)
        }
        
        view.backgroundColor = .white
        tableView.backgroundColor = .white
//
//        tableView.delegate = self
//        tableView.dataSource = self
//
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.pin.all()
    }
}
//
//extension RecipesViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        output.count()
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//
//}
