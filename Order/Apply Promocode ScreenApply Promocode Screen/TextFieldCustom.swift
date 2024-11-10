import UIKit

class TextFieldCustom: UIView {
    private lazy var textView: UIView = {
        let textView = UIView()
        textView.layer.cornerRadius = 12
        textView.layer.borderWidth = 1
        textView.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        return textView
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        if let image = UIImage(named: "ImageClear") {
            button.setImage(image, for: .normal)
        }
        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var textView2: UIView = {
        let textView = UIView()
        return textView
    }()
    
    private lazy var hintLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите код"
        label.textColor = UIColor(named: "ColorNewDarkGray")
        label.font = UIFont(name: "Roboto", size: 12)
        return label
    }()
    
    private lazy var textField: UITextField = {
        let text = UITextField()
        return text
    }()
    
    @objc func clearButtonTapped() {
        textField.text = ""
    }
    
    private func setupView() {
        addSubview(textView)
        addSubview(clearButton)
        addSubview(textView2)
        addSubview(hintLabel)
        addSubview(textField)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        textView2.translatesAutoresizingMaskIntoConstraints = false
        hintLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: topAnchor),
            textView.leftAnchor.constraint(equalTo: leftAnchor),
            textView.rightAnchor.constraint(equalTo: rightAnchor),
            textView.heightAnchor.constraint(equalToConstant: 54),
            
            clearButton.rightAnchor.constraint(equalTo: textView.rightAnchor, constant: -10),
            clearButton.centerYAnchor.constraint(equalTo: textView.centerYAnchor),
            clearButton.widthAnchor.constraint(equalToConstant: 36),
            
            textView2.topAnchor.constraint(equalTo: textView.topAnchor, constant: 8),
            textView2.rightAnchor.constraint(equalTo: clearButton.leftAnchor),
            textView2.leftAnchor.constraint(equalTo: textView.leftAnchor, constant: 20),
            textView2.heightAnchor.constraint(equalToConstant: 38),
            
            hintLabel.topAnchor.constraint(equalTo: textView2.topAnchor),
            hintLabel.leftAnchor.constraint(equalTo: textView2.leftAnchor),
            hintLabel.heightAnchor.constraint(equalToConstant: 16),
            
            textField.topAnchor.constraint(equalTo: hintLabel.bottomAnchor),
            textField.rightAnchor.constraint(equalTo: textView2.rightAnchor),
            textField.leftAnchor.constraint(equalTo: textView2.leftAnchor),
            textField.heightAnchor.constraint(equalToConstant: 22)
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
