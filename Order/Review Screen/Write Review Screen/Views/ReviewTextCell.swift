import UIKit

class ReviewTextCell: UITableViewCell, UITextFieldDelegate {
    private enum Constants {
        static let lightGrayColor = UIColor(named: "ColorNewGray")
        static let font = UIFont(name: "Roboto", size: 16)
        static let dignityText = "Достоинства"
        static let flawsText = "Недостатки"
        static let commentText = "Комментарий"
        static let heightText = 54.0
    }
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var dignityTextField: UITextField = {
        let text = UITextField()
        text.backgroundColor = Constants.lightGrayColor
        text.layer.cornerRadius = 12
        text.delegate = self
        text.placeholder = Constants.dignityText
        text.font = Constants.font
        return text
    }()
    
    private lazy var flawsTextField: UITextField = {
        let text = UITextField()
        text.backgroundColor = Constants.lightGrayColor
        text.layer.cornerRadius = 12
        text.placeholder = Constants.flawsText
        text.font = Constants.font
        return text
    }()
    
    private lazy var commentTextField: UITextField = {
        let text = UITextField()
        text.backgroundColor = Constants.lightGrayColor
        text.layer.cornerRadius = 12
        text.placeholder = Constants.commentText
        text.font = Constants.font
        return text
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setupConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(textFieldTapped))
        dignityTextField.addGestureRecognizer(tapGesture)
    }
    
    @objc func textFieldTapped() {
        dignityTextField.becomeFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ReviewTextCell {
    func addSubviews() {
        contentView.addSubview(containerView)
        
        containerView.addSubview(dignityTextField)
        containerView.addSubview(flawsTextField)
        containerView.addSubview(commentTextField)
    }
    
    func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        dignityTextField.translatesAutoresizingMaskIntoConstraints = false
        flawsTextField.translatesAutoresizingMaskIntoConstraints = false
        commentTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 16),
            containerView.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            dignityTextField.topAnchor.constraint(equalTo: containerView.topAnchor),
            dignityTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            dignityTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            dignityTextField.heightAnchor.constraint(equalToConstant: Constants.heightText),
            
            flawsTextField.topAnchor.constraint(equalTo: dignityTextField.bottomAnchor, constant: 16),
            flawsTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            flawsTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            flawsTextField.heightAnchor.constraint(equalToConstant: Constants.heightText),

            commentTextField.topAnchor.constraint(equalTo: flawsTextField.bottomAnchor, constant: 16),
            commentTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            commentTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            commentTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            commentTextField.heightAnchor.constraint(equalToConstant: Constants.heightText)
        ])
    }
}
