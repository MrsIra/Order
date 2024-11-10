import UIKit

class CheckBoxButtonCell: UITableViewCell {
    private enum Constants {
        static let imageVector = UIImage(named: "Vector")
        static let darkGrayColor = UIColor(named: "ColorNewDarkGray")?.cgColor
        static let newOrangeColor = UIColor(named: "ColorNewTitlePromo")
        static let checkText = "Оставить отзыв анонимно"
    }
    
    private lazy var mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var isChecked = false
    
    private lazy var checkboxButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.imageVector, for: .selected)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderColor = Constants.darkGrayColor
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(toggleCheckbox), for: .touchUpInside)
        return button
    }()
    
    private lazy var checkLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.checkText
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func toggleCheckbox() {
        isChecked.toggle()
        checkboxButton.isSelected = isChecked
        checkboxButton.backgroundColor = isChecked ? Constants.newOrangeColor : UIColor.clear
        checkboxButton.layer.borderColor = isChecked ? UIColor.clear.cgColor : Constants.darkGrayColor
    }
}

private extension CheckBoxButtonCell {
    func addSubviews() {
        contentView.addSubview(mainView)
        mainView.addSubview(checkboxButton)
        mainView.addSubview(checkLabel)
    }
    
    func setupConstraints() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false
        checkLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            mainView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            mainView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            checkboxButton.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 8),
            checkboxButton.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 13),
            checkboxButton.widthAnchor.constraint(equalToConstant: 20),
            checkboxButton.heightAnchor.constraint(equalToConstant: 20),
            
            checkLabel.leftAnchor.constraint(equalTo: checkboxButton.rightAnchor, constant: 10),
            checkLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 8)
        ])
    }
}
