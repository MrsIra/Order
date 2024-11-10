import UIKit

class SendFeedbackButtonCell: UITableViewCell {
    private enum Constants {
        static let darkGrayColor = UIColor(named: "ColorNewDarkGray")
        static let newOrangeColor = UIColor(named: "ColorNewTitlePromo")
        static let title = "Отправить"
        static let font = UIFont(name: "Roboto", size: 16)
    }
    
    var sendButtonAction: (() -> (Bool))?
    var showError: ((String) -> Void)?
    
    private lazy var mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var sendFeedbackButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Constants.font
        button.backgroundColor = Constants.newOrangeColor
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = true
        textView.attributedText = createAttributedString()
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped() {
        let isTheArrayFull = sendButtonAction?()
        if isTheArrayFull == false {
            showError?("Поставьте оценку товару")
        }
    }
}

private extension SendFeedbackButtonCell {
    func createAttributedString() -> NSAttributedString {
        let text = "Перед отправкой отзыва, пожалуйста, ознакомьтесь с правилами публикации"
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.foregroundColor, value: Constants.darkGrayColor ?? .black, range: NSRange(location: 0, length: text.count))
        
        let linkRange = (text as NSString).range(of: "правилами публикации")
        attributedString.addAttribute(.foregroundColor, value: Constants.newOrangeColor ?? .red, range: linkRange)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: text.count))
        
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 12), range: NSRange(location: 0, length: text.count))
        
        return attributedString
    }
    
    func addSubviews() {
        contentView.addSubview(mainView)
        mainView.addSubview(sendFeedbackButton)
        mainView.addSubview(textView)
    }
    
    func setupConstraints() {
        sendFeedbackButton.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            mainView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            mainView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            sendFeedbackButton.topAnchor.constraint(equalTo: mainView.topAnchor),
            sendFeedbackButton.leftAnchor.constraint(equalTo: mainView.leftAnchor),
            sendFeedbackButton.rightAnchor.constraint(equalTo: mainView.rightAnchor),
            sendFeedbackButton.heightAnchor.constraint(equalToConstant: 54),
            
            textView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 30),
            textView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -30),
            textView.heightAnchor.constraint(equalToConstant: 40),
            textView.topAnchor.constraint(equalTo: sendFeedbackButton.bottomAnchor, constant: 10),
            textView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10)
        ])
    }
}
