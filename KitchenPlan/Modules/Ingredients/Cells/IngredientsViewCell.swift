import UIKit
import PinLayout
import Kingfisher

final class IngredientsViewCell: UICollectionViewCell {
    private let container = UIView()
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    static let indetifier = "IngredientsCollectionViewCell"
    private let checkbox = UIImageView()
    private var isEditing = false
    
    override var isSelected: Bool {
        didSet {
            if !self.isEditing {
                checkbox.image = nil
                return
            }
            
            if self.isSelected {
                checkbox.image = UIImage(systemName: "checkmark.circle.fill")
            } else {
                checkbox.image = UIImage(systemName: "checkmark.circle")
            }
        }
    }

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
        imageView.contentMode = .scaleAspectFill
        titleLabel.font = .systemFont(ofSize: 10, weight: .regular)
        titleLabel.textColor = .black
        checkbox.contentMode = .scaleAspectFit

        [imageView, titleLabel, checkbox].forEach {
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
        
        checkbox.pin
            .right(5)
            .bottom(5)
            .height(16)
            .width(16)
    }

    func configure(with model: IngredientViewModel, isEditing: Bool = false) {
        titleLabel.text = model.title
        if let url = model.image {
            imageView.kf.setImage(
                with: URL(string: url),
                placeholder: UIImage(named: "ingredientPlaceholder"))
        } else {
            imageView.image = UIImage(named: "ingredientPlaceholder")
        }
        
        self.isEditing = isEditing
        if isEditing {
            checkbox.image = UIImage(systemName: "checkmark.circle")
        } else {
            checkbox.image = nil
        }
    }
    
    func resetCheckbox() {
        isEditing = false
        checkbox.image = nil
    }
}
