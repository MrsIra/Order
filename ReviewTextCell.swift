import UIKit

class ReviewTextCell: UITableViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView()
//        view.backgroundColor = .yellow
        return view
    }()
    
    private lazy var dignityTextField: UITextField = {
        let text = UITextField()
        text.backgroundColor = UIColor(named: "ColorNewGray")
        text.layer.cornerRadius = 12
//        text.textColor = UIColor(named: "ColorNewDarkGray")
        text.placeholder = "Достоинства"
        text.font = UIFont(name: "Roboto", size: 16)
        return text
    }()
    
    private lazy var flawsTextField: UITextField = {
        let text = UITextField()
        text.backgroundColor = UIColor(named: "ColorNewGray")
        text.layer.cornerRadius = 12
//        text.textColor = UIColor(named: "ColorNewDarkGray")
        text.placeholder = "Недостатки"
        text.font = UIFont(name: "Roboto", size: 16)
        return text
    }()
    
    private lazy var commentTextField: UITextField = {
        let text = UITextField()
        text.backgroundColor = UIColor(named: "ColorNewGray")
        text.layer.cornerRadius = 12
//        text.textColor = UIColor(named: "ColorNewDarkGray")
        text.placeholder = "Комментарий"
        text.font = UIFont(name: "Roboto", size: 16)
        return text
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(dignityTextField)
        containerView.addSubview(flawsTextField)
        containerView.addSubview(commentTextField)
        
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
//            dignityTextField.bottomAnchor.constraint(equalTo: flawsTextField.topAnchor),
            dignityTextField.heightAnchor.constraint(equalToConstant: 54),
            
            flawsTextField.topAnchor.constraint(equalTo: dignityTextField.bottomAnchor, constant: 16),
            flawsTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            flawsTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor),
//            flawsTextField.bottomAnchor.constraint(equalTo: commentTextField.topAnchor),
            flawsTextField.heightAnchor.constraint(equalToConstant: 54),

            commentTextField.topAnchor.constraint(equalTo: flawsTextField.bottomAnchor, constant: 16),
            commentTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            commentTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            commentTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            commentTextField.heightAnchor.constraint(equalToConstant: 54)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
