import UIKit

class TitleImageTextCell: UITableViewCell {
    private enum Constants {
        static let darkGrayColor = UIColor(named: "ColorNewDarkGray")
        static let font = UIFont(name: "Roboto", size: 14)
    }
    
    private lazy var mainView: UIView = {
        let mainView = UIView()
        return mainView
    }()
    
    private let customImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var descriptionView: UIView = {
        let descriptionView = UIView()
        return descriptionView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.font
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.font
        label.textColor = Constants.darkGrayColor
        label.numberOfLines = 0
        return label
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
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}

private extension TitleImageTextCell {
    func addSubviews() {
        contentView.addSubview(mainView)
        mainView.addSubview(customImageView)
        mainView.addSubview(descriptionView)
        descriptionView.addSubview(titleLabel)
        descriptionView.addSubview(subtitleLabel)
    }
    
    func setupConstraints() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        customImageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            mainView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            mainView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            customImageView.topAnchor.constraint(equalTo: mainView.topAnchor),
            customImageView.leftAnchor.constraint(equalTo: mainView.leftAnchor),
            customImageView.widthAnchor.constraint(equalToConstant: 80),
            
            descriptionView.topAnchor.constraint(equalTo: mainView.topAnchor),
            descriptionView.leftAnchor.constraint(equalTo: customImageView.rightAnchor, constant: 8),
            descriptionView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -10),
            descriptionView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: descriptionView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: descriptionView.rightAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subtitleLabel.leftAnchor.constraint(equalTo: descriptionView.leftAnchor),
            subtitleLabel.rightAnchor.constraint(equalTo: descriptionView.rightAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: -8),
        ])
    }
}
