import UIKit

class ButtonPromocode: UITableViewCell {
    var viewModel: TableViewModel.ViewModelType.Button? {
        didSet {
            updateUI()
        }
    }
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        return button
    }()
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private func updateUI() {
        guard let viewModel else {
            return
        }
        
        if let hexColor = viewModel.backgroundHexColor {
            button.backgroundColor = UIColor(named: "ColorNewPromo")
        }
        
        if let promocodeImage = viewModel.image {
            image.image = promocodeImage
        }
        
        if let buttonTitle = viewModel.title {
            if let titleHexColor = viewModel.titleHexColor {
                self.title.textColor = UIColor(named: "ColorNewTitlePromo")
            }
            title.text = buttonTitle
        }
    }
    
    private func setupUI() {
        contentView.addSubview(button)
        contentView.addSubview(image)
        contentView.addSubview(title)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            button.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            button.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            image.topAnchor.constraint(equalTo: button.topAnchor, constant: 16),
            image.leftAnchor.constraint(equalTo: button.leftAnchor, constant: 75),
            image.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -16),
            
            title.topAnchor.constraint(equalTo: button.topAnchor, constant: 16),
            title.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 10),
            title.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -16)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
