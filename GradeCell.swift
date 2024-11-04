import UIKit

class GradeCell: UITableViewCell {
    private lazy var gradeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "ColorNewGray")
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var gradeLabel: UILabel = {
        let label = UILabel()
        label.text = "Ваша оценка"
        label.textColor = UIColor(named: "ColorNewDarkGray")
        label.font = UIFont(name: "Roboto", size: 16)
        return label
    }()
    
    private lazy var starView: UIView = {
        let view = UIView()
//        view.backgroundColor = .red
        return view
    }()
    
    private lazy var starButtons = [UIButton]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(gradeView)
        gradeView.addSubview(gradeLabel)
        
        gradeView.translatesAutoresizingMaskIntoConstraints = false
        gradeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 54),
            
            gradeView.topAnchor.constraint(equalTo: contentView.topAnchor),
            gradeView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            gradeView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            gradeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            gradeLabel.centerYAnchor.constraint(equalTo: gradeView.centerYAnchor),
            gradeLabel.leftAnchor.constraint(equalTo: gradeView.leftAnchor, constant: 16)
        ])
        
        gradeView.addSubview(starView)

        starView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            starView.centerYAnchor.constraint(equalTo: gradeView.centerYAnchor),
            starView.rightAnchor.constraint(equalTo: gradeView.rightAnchor, constant: -16),
            starView.widthAnchor.constraint(equalToConstant: 136),
            starView.bottomAnchor.constraint(equalTo: gradeView.bottomAnchor)
        ])
        
        for index in 0...4 {
            let button = UIButton(type: .custom)
            if let image = UIImage(named: "StarClear") {
                button.setImage(image, for: .normal)
            }
            button.tag = index
            button.addTarget(self, action: #selector(starButtonTapped(_ :)), for: .touchUpInside)
            starButtons.append(button)
        }

        for index in 0...starButtons.count - 1 {
            starView.addSubview(starButtons[index])
            starButtons[index].translatesAutoresizingMaskIntoConstraints = false

            if index == 0 {
                NSLayoutConstraint.activate([
                    starButtons[index].centerYAnchor.constraint(equalTo: starView.centerYAnchor),
                    starButtons[index].leftAnchor.constraint(equalTo: starView.leftAnchor)
                ])
            } else {
                NSLayoutConstraint.activate([
                    starButtons[index].centerYAnchor.constraint(equalTo: starView.centerYAnchor),
                    starButtons[index].leftAnchor.constraint(equalTo: starButtons[index - 1].rightAnchor, constant: 4)
                ])
            }
        }
    }
    
    @objc func starButtonTapped(_ sender: UIButton) {
//                print("hi")
        let index = sender.tag
        
        gradeLabel.textColor = .black
        
        switch index {
        case 0:
            gradeLabel.text = "Ужасно"
        case 1:
            gradeLabel.text = "Плохо"
        case 2:
            gradeLabel.text = "Нормально"
        case 3:
            gradeLabel.text = "Хорошо"
        case 4:
            gradeLabel.text = "Отлично"
        default:
            break
        }
        
        for button in starButtons {
            if button.tag <= index {
                if let image = UIImage(named: "StarYellow") {
                    button.setImage(image, for: .normal)
                }
            } else {
                if let image = UIImage(named: "StarClear") {
                    button.setImage(image, for: .normal)
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
