import UIKit

final class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        guard let bar = navigationController?.navigationBar else {
            return
        }
        overrideNavigateBar(bar)
    }
}
