import UIKit

class CheckBoxButtonCell: UITableViewCell {
    private lazy var mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var isChecked = false
    
    private lazy var checkboxButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Checkbox1"), for: .selected)
        button.setImage(UIImage(named: "Checkbox1"), for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = .systemFont(ofSize: 50)
        button.addTarget(self, action: #selector(toggleCheckbox), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.addSubview(checkboxButton)
        
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor),
            mainView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            mainView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            checkboxButton.topAnchor.constraint(equalTo: mainView.topAnchor),
            checkboxButton.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 10),
            checkboxButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func toggleCheckbox() {
        isChecked.toggle()
        checkboxButton.isSelected = isChecked
//        contentView.backgroundColor = isChecked ? UIColor.red : UIColor.clear
    }
}
