import UIKit
import Kingfisher
import PinLayout

final class ReceiptsViewController: UIViewController {
    private let image = UIImageView()
    private let model: RecipesViewModel
    private let receiptTitle = UILabel()
    
    init(city: RecipesViewModel) {
        self.model = city
        
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
        
        image.kf.setImage(
            with: URL(string: model.image),
            placeholder: UIImage(named: "receptPlaceholder"))
        
        title = model.title
        receiptTitle.text = model.title
        receiptTitle.lineBreakMode = .byWordWrapping
        receiptTitle.numberOfLines = 0
        
        receiptTitle.font = .systemFont(ofSize: 24, weight: .bold)
        receiptTitle.textColor = .black
        
        [image, receiptTitle].forEach {
            view.addSubview($0)
        }
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
