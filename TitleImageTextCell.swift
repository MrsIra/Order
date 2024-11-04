import UIKit

class TitleImageTextCell: UITableViewCell {
    private lazy var mainView: UIView = {
        let mainView = UIView()
//        mainView.backgroundColor = .gray//UIColor(named: "ColorNewGray")
        return mainView
    }()
    
    private let customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Image1")
        return imageView
    }()
    
    private lazy var descriptionView: UIView = {
        let descriptionView = UIView()
        return descriptionView
    }()
    
    private let customLabel: UILabel = {
        let label = UILabel()
        label.text = "Золотое плоское обручальное кольцо 4 мм"
        label.font = UIFont(name: "Roboto", size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var cusLabel: UILabel = {
        let label = UILabel()
        label.text = "Размер: 17"
        label.font = UIFont(name: "Roboto", size: 14)
        label.textColor = UIColor(named: "ColorNewDarkGray")
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        contentView.backgroundColor = UIColor(named: "ColorNewGray")
        
        contentView.addSubview(mainView)
        mainView.addSubview(customImageView)
        mainView.addSubview(descriptionView)
        descriptionView.addSubview(customLabel)
        descriptionView.addSubview(cusLabel)
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        customImageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        customLabel.translatesAutoresizingMaskIntoConstraints = false
        cusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            mainView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            mainView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            customImageView.topAnchor.constraint(equalTo: mainView.topAnchor),
            customImageView.leftAnchor.constraint(equalTo: mainView.leftAnchor),
            customImageView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            
            descriptionView.topAnchor.constraint(equalTo: mainView.topAnchor),
            descriptionView.leftAnchor.constraint(equalTo: customImageView.rightAnchor, constant: 8),
            descriptionView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -10),
            descriptionView.heightAnchor.constraint(equalTo: customImageView.heightAnchor),
            
            customLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 8),
            customLabel.leftAnchor.constraint(equalTo: descriptionView.leftAnchor),
            customLabel.rightAnchor.constraint(equalTo: descriptionView.rightAnchor),
            
            cusLabel.topAnchor.constraint(equalTo: customLabel.bottomAnchor),
            cusLabel.leftAnchor.constraint(equalTo: descriptionView.leftAnchor),
            cusLabel.rightAnchor.constraint(equalTo: descriptionView.rightAnchor),
//            cusLabel.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
