import UIKit

final class ProfileActionCell: UITableViewCell {
    static let indentifier = "PofileActionCell"
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let arrowImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = .white
        selectionStyle = .none
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = UIColor.white
        
        titleLabel.font = .systemFont(ofSize: 20, weight: .medium)
        titleLabel.textColor = .black
        
        arrowImage.image = UIImage(systemName: "chevron.forward")
        arrowImage.tintColor = .gray
        
        [iconView, titleLabel, arrowImage].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.pin
            .horizontally(10)
            .vertically(5)
        
        iconView.pin
            .vCenter()
            .left(10)
            .height(24)
            .width(24)
        
        arrowImage.pin
            .vCenter()
            .right(10)
            .width(16)
            .sizeToFit(.width)
        
        titleLabel.pin
            .vCenter()
            .after(of: iconView)
            .before(of: arrowImage)
            .marginLeft(10)
            .height(20)
            .sizeToFit(.content)
    }
    
    func configure(with model: ProfileAction) {
        iconView.image = UIImage(named: model.image)
        titleLabel.text = model.title
    }
}
