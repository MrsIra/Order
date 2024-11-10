import UIKit

class ApplyPromocodeButton: UIButton {
    private enum Constants {
        static let titleButton = "Применить промокод"
        static let newOrangeColor = UIColor(named: "ColorNewTitlePromo")
        static let imagePromo = UIImage(named: "ImagePromo")
        static let backgroundColorButton = UIColor(named: "ColorNewPromo")
        static let fontButton = UIFont(name: "Roboto", size: 16)
    }
    
    var onApplyButtonTapped: (() -> (Void))?
    
    private lazy var applyButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.titleButton, for: .normal)
        button.setTitleColor(Constants.newOrangeColor, for: .normal)
        if let image = Constants.imagePromo {
            button.setImage(image, for: .normal)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        }
        button.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
        
        button.titleLabel?.font = Constants.fontButton
        button.backgroundColor = Constants.backgroundColorButton
        button.layer.cornerRadius = 12
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(applyButton)
        
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            applyButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            applyButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            applyButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            applyButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    @objc func applyButtonTapped() {
        onApplyButtonTapped?()
    }
}
