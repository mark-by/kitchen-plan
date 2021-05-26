import UIKit
import PinLayout

final class MainReceiptInfoCell: UITableViewCell {
    private let image = UIImageView()
    private let receiptTitle = UILabel()
    private let typeLabel = UILabel()
    private let timeToCook = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
           
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        selectionStyle = .none
        
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        backgroundColor = .white
        
        image.clipsToBounds = true
        
        receiptTitle.lineBreakMode = .byWordWrapping
        receiptTitle.numberOfLines = 0
        
        receiptTitle.font = .systemFont(ofSize: 27, weight: .bold)
        receiptTitle.textColor = .black
        
        typeLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        typeLabel.textColor = .darkGray
        
        timeToCook.font = .systemFont(ofSize: 18, weight: .semibold)
        timeToCook.textColor = .darkGray
        
        [image, receiptTitle, typeLabel, timeToCook].forEach{
            contentView.addSubview($0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    
    func layout() {
        image.pin
            .height(200)
            .width(100%)
            .top()
        
        image.contentMode = .scaleAspectFill
        
        receiptTitle.pin.below(of: image).horizontally().margin(10).sizeToFit(.width)
        
        typeLabel.pin
            .below(of: receiptTitle)
            .width(50%)
            .marginTop(10)
            .left(10)
            .sizeToFit(.content)
        
        timeToCook.pin
            .below(of: receiptTitle)
            .marginTop(10)
            .right(10)
            .sizeToFit(.content)
    }
    
    func configure(with model: RecipesViewModel, type: String) {
        image.kf.setImage(
            with: URL(string: model.image),
            placeholder: UIImage(named: "receptPlaceholder"))
        
        receiptTitle.text = model.title
        typeLabel.text = type.lowercased()
        timeToCook.text = model.timeToCook
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)

        layout()
            
        return CGSize(width: contentView.frame.width, height: typeLabel.frame.maxY + 10)
    }
}
