import UIKit
import PinLayout
import Kingfisher

final class IngredientsViewCell: UICollectionViewCell {
    private let container = UIView()
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    static let indetifier = "IngredientsCollectionViewCell"

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.backgroundColor = UIColor.white

        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowRadius = 9
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.cornerRadius = 8

        imageView.clipsToBounds = true
        titleLabel.font = .systemFont(ofSize: 10, weight: .regular)
        titleLabel.textColor = .black

        [imageView, titleLabel].forEach {
            container.addSubview($0)
        }

        container.layer.cornerRadius = 5
        container.clipsToBounds = true

        contentView.addSubview(container)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.pin
            .horizontally(10)
            .vertically(10)

        container.pin
            .width(20%)
            .height(20%)

        container.pin.all()

        imageView.pin
            .horizontally()
            .height(70%)

        titleLabel.pin
            .bottom(8)
            .left(12)
            .height(20)
            .maxWidth(70%)
            .sizeToFit(.height)
    }

    func configure(with model: IngredientViewModel) {
        titleLabel.text = model.title
        if let url = model.image {
            imageView.kf.setImage(
                with: URL(string: url),
                placeholder: UIImage(named: "ingredientPlaceholder"))
        } else {
            imageView.image = UIImage(named: "ingredientPlaceholder")
        }
    }
}
