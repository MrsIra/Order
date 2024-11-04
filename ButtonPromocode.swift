import UIKit

class ButtonPromocode: UIButton {
    
    var onApplyButtonTapped: (() -> (Void))?
    
    private lazy var applyPromocodeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Применить промокод", for: .normal)
        button.setTitleColor(UIColor(named: "ColorNewTitlePromo"), for: .normal)
        if let image = UIImage(named: "ImagePromo") {
            button.setImage(image, for: .normal)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        }
                button.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
        
        button.titleLabel?.font = UIFont(name: "Roboto", size: 16)
        button.backgroundColor = UIColor(named: "ColorNewPromo")
        button.layer.cornerRadius = 12
        return button
    }()
    
    private func setupUI() {
        addSubview(applyPromocodeButton)
        
        applyPromocodeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            applyPromocodeButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            applyPromocodeButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            applyPromocodeButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            applyPromocodeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    @objc func applyButtonTapped() {
        onApplyButtonTapped?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
