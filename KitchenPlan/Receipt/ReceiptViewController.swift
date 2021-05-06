import UIKit
import PinLayout
import Kingfisher

final class ReceiptViewController: UIViewController {
	private let output: ReceiptViewOutput
    private let image = UIImageView()
    private let model: RecipesViewModel
    private let receiptTitle = UILabel()
    private let steps = UITableView()
    private let ingredients = UITableView()
    
    init(output: ReceiptViewOutput, model: RecipesViewModel) {
        self.output = output
        self.model = model

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let bar = navigationController?.navigationBar {
            overrideNavigateBar(bar)
        }
        view.backgroundColor = .white
        
        image.kf.setImage(
            with: URL(string: model.image),
            placeholder: UIImage(named: "receptPlaceholder"))
        
        title = model.title
        receiptTitle.text = model.title
        receiptTitle.lineBreakMode = .byWordWrapping
        receiptTitle.numberOfLines = 0
        
        receiptTitle.font = .systemFont(ofSize: 24, weight: .bold)
        receiptTitle.textColor = .black
        
        [image, receiptTitle, steps, ingredients].forEach {
            view.addSubview($0)
        }
        
        self.output.didLoadView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        image.pin
            .height(150)
            .width(100%)
            .top()
        
        image.contentMode = .scaleAspectFill
        
        receiptTitle.pin
            .below(of: image)
            .margin(15, 5, 15)
            .left(2)
            .maxWidth(100%).sizeToFit()
    }
}

extension ReceiptViewController: ReceiptViewInput {
    func loadData(with model: Receipt) {
        print("GET RECEIPT IN VIEW: ", model)
    }
    
}
