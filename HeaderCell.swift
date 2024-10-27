import UIKit

class HeaderView: UIView {
    private lazy var promocodeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Промокоды"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "HelveticaNeue", size: 24)
        return label
    }()
    
    private lazy var promocodeSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "На один товар можно применить только один промокод"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private func setupView() {
        addSubview(promocodeTitleLabel)
        addSubview(promocodeSubtitleLabel)
        
        promocodeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        promocodeSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            promocodeTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            promocodeTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            promocodeTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            promocodeSubtitleLabel.topAnchor.constraint(equalTo: promocodeTitleLabel.bottomAnchor, constant: 10),
            promocodeSubtitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            promocodeSubtitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            promocodeSubtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

