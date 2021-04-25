import UIKit
import PinLayout

final class RecipesTableViewCell: UITableViewCell {
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
        titleLabel.backgroundColor = .white.withAlphaComponent(0.8)
        titleLabel.layer.masksToBounds = true
        titleLabel.layer.cornerRadius = 5
        
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
        timeLabel.backgroundColor = .white.withAlphaComponent(0.8)
        timeLabel.layer.masksToBounds = true
        timeLabel.layer.cornerRadius = 5
        
        [image, titleLabel, timeLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.pin
                    .horizontally(12)
                    .vertically(10)
        contentView.clipsToBounds = true
        
        titleLabel.pin
                    .bottom(8)
                    .left(12)
                    .height(20)
                    .sizeToFit(.height)
        
        timeLabel.pin
            .bottom(8)
            .right(12)
            .height(20)
            .sizeToFit(.content)
        
        image.pin.all()
        image.contentMode = .scaleAspectFill
    }
    
    func configure(with model: RecipesViewModel) {
        titleLabel.text = model.title
        timeLabel.text = "30 мин"

        image.image = UIImage(data: Data.init(base64Encoded: base64Image)!)
    }
}
