import UIKit
import PinLayout
import Kingfisher

final class IngredientsViewCell: UICollectionViewCell {
    private let container = UIView()
    private let titleLabel = UILabel()
    private let image = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .secondarySystemBackground

        contentView.clipsToBounds = true
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowRadius = 9
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = UIColor.white

        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        titleLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        titleLabel.textColor = .darkGray

        [image, titleLabel].forEach {
            container.addSubview($0)
        }
        
        container.layer.cornerRadius = 5
        container.clipsToBounds = true
        
        contentView.addSubview(container)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        container.pin
            .width(20%)
            .height(20%)
        
        container.pin.all()
        
        image.pin
            .width(100%)
            .height(70%)

        titleLabel.pin
            .bottom(8)
            .left(12)
            .height(20)
            .maxWidth(70%)
            .sizeToFit(.height)
    }

    func configure(with model: IngredientsViewModel) {
        titleLabel.text = model.title
        image.kf.setImage(
            with: URL(string: model.image),
            placeholder: UIImage(named: "ingredientPlaceholder"))
    }
}
