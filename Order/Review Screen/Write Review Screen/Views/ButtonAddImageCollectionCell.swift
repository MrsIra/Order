import UIKit

class ButtonAddImageCell: UICollectionViewCell {
    private enum Constants {
        static let lightGrayColor = UIColor(named: "ColorNewGray")
        static let cloudUpload = UIImage(named: "CloudUpload")
        static let font = UIFont(name: "Roboto", size: 16)
    }
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        if let image = Constants.cloudUpload {
            button.setImage(image, for: .normal)
            button.imageEdgeInsets = UIEdgeInsets()
        }
        button.titleLabel?.font = Constants.font
        button.backgroundColor = Constants.lightGrayColor
        button.layer.cornerRadius = 12
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addButton.heightAnchor.constraint(equalToConstant: 80),
            addButton.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

