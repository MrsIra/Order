import UIKit

class ProductCell: UITableViewCell {
    private enum Constants {
        static let font = UIFont(name: "Roboto", size: 14)
        static let imageProduct = UIImage(named: "ChevronRight")
    }
    
    private lazy var mainView: UIView = {
        let mainView = UIView()
        return mainView
    }()
    
    private let customImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let customLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.font
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var goToReviewButton: UIButton = {
        let button = UIButton()
        if let image = Constants.imageProduct {
            button.setImage(image, for: .normal)
        }
        return button
    }()
    
    private lazy var descriptionView: UIView = {
        let descriptionView = UIView()
        return descriptionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: UIImage, title: String, subtitle: String) {
        customImageView.image = image
        customLabel.text = title
    }
}

private extension ProductCell {
    func addSubviews() {
        contentView.addSubview(mainView)
        contentView.addSubview(customImageView)
        contentView.addSubview(descriptionView)
        contentView.addSubview(customLabel)
        contentView.addSubview(goToReviewButton)
    }
    
    func setupConstraints() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        customImageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        customLabel.translatesAutoresizingMaskIntoConstraints = false
        goToReviewButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            customImageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 8),
            customImageView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 8),
            customImageView.widthAnchor.constraint(equalToConstant: 80),
            customImageView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -8),
            
            descriptionView.topAnchor.constraint(equalTo: mainView.topAnchor),
            descriptionView.leftAnchor.constraint(equalTo: customImageView.rightAnchor, constant: 10),
            descriptionView.rightAnchor.constraint(equalTo: mainView.rightAnchor),
            
            customLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 8),
            customLabel.leftAnchor.constraint(equalTo: descriptionView.leftAnchor),
            customLabel.rightAnchor.constraint(equalTo: goToReviewButton.leftAnchor, constant: -8),
            
            goToReviewButton.rightAnchor.constraint(equalTo: descriptionView.rightAnchor),
            goToReviewButton.centerYAnchor.constraint(equalTo: mainView.centerYAnchor)
        ])
    }
}
