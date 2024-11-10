import UIKit

class HeaderView: UIView {
    private enum Constants {
        static let title = "Промокоды"
        static let subtitle = "На один товар можно применить только один промокод"
        static let left = 20.0
        static let right = -20.0
        static let top = 8.0
        static let bottom = -8.0
    }
    
    private lazy var promocodeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.title
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "Roboto", size: 24)
        return label
    }()
    
    private lazy var promocodeSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.subtitle
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: "Roboto", size: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(promocodeTitleLabel)
        addSubview(promocodeSubtitleLabel)
        
        promocodeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        promocodeSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            promocodeTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            promocodeTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.left),
            promocodeTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: Constants.right),
            
            promocodeSubtitleLabel.topAnchor.constraint(equalTo: promocodeTitleLabel.bottomAnchor, constant: Constants.top),
            promocodeSubtitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.left),
            promocodeSubtitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant:Constants.right),
            promocodeSubtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.bottom)
        ])
    }
}

