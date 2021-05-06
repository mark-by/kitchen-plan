import UIKit
import PinLayout
import Kingfisher

final class RecipesTableViewCell: UITableViewCell {
    private let container = UIView()
    private let titleLabel = UILabel()
    private let image = UIImageView()
    private let timeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
           
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .black
        
        backgroundColor = .white
                
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowRadius = 9
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = UIColor.white
        
        selectionStyle = .none
        
        timeLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        timeLabel.textColor = .darkGray
        
        image.clipsToBounds = true
        
        [image, titleLabel, timeLabel].forEach {
            container.addSubview($0)
        }
        
        container.layer.cornerRadius = 5
        container.clipsToBounds = true
        
        contentView.addSubview(container)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.pin
                    .horizontally(12)
                    .vertically(10)
        
        container.pin.all()
        
        image.pin
            .width(100%)
            .height(145)
        
        image.contentMode = .scaleAspectFill
        
        
        titleLabel.pin
            .bottom(8)
            .left(12)
            .height(20)
            .maxWidth(70%)
            .sizeToFit(.height)
        
        timeLabel.pin
            .bottom(8)
            .right(12)
            .height(20)
            .sizeToFit(.content)
    }
    
    func configure(with model: RecipesViewModel) {
        titleLabel.text = model.title
        timeLabel.text = model.timeToCook
        image.kf.setImage(
            with: URL(string: model.image),
            placeholder: UIImage(named: "receptPlaceholder"))
    }
}
