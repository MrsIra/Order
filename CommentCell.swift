//import UIKit
//
import UIKit

class CommentCell: UITableViewCell {
    
    private lazy var mainView: UIView = {
        let mainView = UIView()
        return mainView
    }()
    
    private let customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Image1")
        return imageView
    }()
    
    private let customLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        label.font = UIFont(name: "Roboto", size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var goToReviewButton: UIButton = {
        let button = UIButton()
        if let image = UIImage(named: "ChevronRight") {
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
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(mainView)
        contentView.addSubview(customImageView)
        contentView.addSubview(descriptionView)
        contentView.addSubview(customLabel)
        contentView.addSubview(goToReviewButton)
        
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
    
    func configure(image: UIImage, text: String) {
        customImageView.image = image
        customLabel.text = text
    }
}
