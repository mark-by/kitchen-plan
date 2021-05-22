import UIKit

final class CreateReceiptViewController: UIViewController {
	private let output: CreateReceiptViewOutput

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
        view.backgroundColor = .white
        
        [].forEach {
            view.addSubview($0)
        }
	}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
}

extension CreateReceiptViewController: CreateReceiptViewInput {
}
