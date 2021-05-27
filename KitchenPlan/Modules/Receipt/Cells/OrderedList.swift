import UIKit
import PinLayout

final class OrderedList: UITableViewCell {
    private let title = UILabel()
    private var items: [UILabel] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
           
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        selectionStyle = .none
        
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        backgroundColor = .white
        
        title.textColor = .black
        title.font = .systemFont(ofSize: 24, weight: .semibold)
        [title].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }

    func configure(title: String, with items: [String]) {
        self.title.text = title
        
        items.enumerated().forEach { (idx, item) in
            let text = "\(idx + 1). \(item)"
            
            let label = UILabel()
            label.text = text
            label.textColor = .black
            label.font = .systemFont(ofSize: 16, weight: .medium)
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
            
            self.items.append(label)
            contentView.addSubview(label)
        }
    }
    
    func layout() {
        title.pin
            .horizontally()
            .margin(10)
            .sizeToFit(.width)
        
        if self.items.count > 0 {
            layoutIngredients()
        }
    }
    
    func layoutIngredients() {
        self.items[0].pin
            .below(of: title)
            .horizontally()
            .margin(10)
            .sizeToFit(.width)
        
        if self.items.count == 1 {
            return
        }
        
        self.items[1...].enumerated().forEach { (idx, item) in
            self.items[idx+1].pin
                .below(of: self.items[idx])
                .horizontally()
                .margin(10)
                .sizeToFit(.width)
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)

        layout()
        
        let maxY = items.last?.frame.maxY ?? title.frame.maxY
        
        return CGSize(width: contentView.frame.width, height: maxY + 10)
    }
}
