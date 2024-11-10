import UIKit

class PromocodeCell: UITableViewCell {
    private enum Constants {
        static let lightGrayColor = UIColor(named: "ColorNewGray")
        static let greenColor = UIColor(named: "ColorNewGreen")
        static let imageInfo = UIImage(named: "ImageInfo")
        static let newOrangeColor = UIColor(named: "ColorNewTitlePromo")
        static let darkGrayColor = UIColor(named: "ColorNewDarkGray")
        static let font = "Roboto"
    }
    
    var promocode: Order.Promocode? {
        didSet {
            updateUI()
        }
    }

    var togglePromo: ((String) -> ())?
    
    private lazy var promocodeTableCell: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.lightGrayColor
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var circleLeft: CircleView = {
        let circle = CircleView()
        circle.backgroundColor = .clear
        return circle
    }()
    
    private lazy var circleRight: CircleView = {
        let circle = CircleView()
        circle.backgroundColor = .clear
        return circle
    }()
    
    private lazy var mainInfoCell: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var promocodeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Constants.font, size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var discountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = Constants.greenColor
        label.text = "0%"
        label.textAlignment = .center
        label.font = UIFont(name: Constants.font, size: 12)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()
    
    private lazy var infoButton: UIButton = {
        let button = UIButton()
        if let image = Constants.imageInfo {
            button.setImage(image, for: .normal)
        }
        return button
    }()
    
    private lazy var switchButton: UISwitch = {
        let button = UISwitch()
        button.onTintColor = Constants.newOrangeColor
        button.layer.cornerRadius = button.frame.height / 2
        button.backgroundColor = Constants.darkGrayColor
        button.isOn = false
        button.addTarget(self, action: #selector(toggle), for: .valueChanged)
        return button
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.font, size: 14)
        label.textColor = Constants.darkGrayColor
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: Constants.font, size: 16)
        label.textColor = Constants.darkGrayColor
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

    @objc func toggle() {
        guard let promocode else { return }
        togglePromo?(promocode.id)
    }
}

private extension PromocodeCell {
    func updateUI() {
        guard let promocode else { return }

        promocodeLabel.text = promocode.title
        switchButton.isOn = promocode.active
        dateLabel.text = formattedDate(promocode.endDate)
        discountLabel.text = "-\(promocode.percent)%"

        if let infoText = promocode.info {
            infoLabel.text = infoText
            infoLabel.isHidden = false
        } else {
            infoLabel.isHidden = true
        }
    }
    
    func formattedDate(_ date: Date?) -> String {
        guard let date = date else { return "" }
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
    
    func addSubviews() {
        contentView.addSubview(promocodeTableCell)
        contentView.addSubview(circleLeft)
        contentView.addSubview(circleRight)
        contentView.addSubview(mainInfoCell)
        
        mainInfoCell.addSubview(promocodeLabel)
        mainInfoCell.addSubview(discountLabel)
        mainInfoCell.addSubview(infoButton)
        mainInfoCell.addSubview(switchButton)
        mainInfoCell.addSubview(dateLabel)
        mainInfoCell.addSubview(infoLabel)
    }
    
    private func setupConstraints() {
        promocodeTableCell.translatesAutoresizingMaskIntoConstraints = false
        circleLeft.translatesAutoresizingMaskIntoConstraints = false
        circleRight.translatesAutoresizingMaskIntoConstraints = false
        mainInfoCell.translatesAutoresizingMaskIntoConstraints = false
        
        promocodeLabel.translatesAutoresizingMaskIntoConstraints = false
        discountLabel.translatesAutoresizingMaskIntoConstraints = false
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            promocodeTableCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            promocodeTableCell.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            promocodeTableCell.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            promocodeTableCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            circleLeft.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            circleLeft.centerYAnchor.constraint(equalTo: promocodeTableCell.centerYAnchor),
            circleLeft.widthAnchor.constraint(equalToConstant: 16),
            circleLeft.heightAnchor.constraint(equalTo: circleLeft.widthAnchor),
            
            circleRight.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            circleRight.centerYAnchor.constraint(equalTo: promocodeTableCell.centerYAnchor),
            circleRight.widthAnchor.constraint(equalToConstant: 16),
            circleRight.heightAnchor.constraint(equalTo: circleRight.widthAnchor),
            
            mainInfoCell.topAnchor.constraint(equalTo: promocodeTableCell.topAnchor, constant: 12),
            mainInfoCell.leftAnchor.constraint(equalTo: promocodeTableCell.leftAnchor, constant: 20),
            mainInfoCell.trailingAnchor.constraint(equalTo: promocodeTableCell.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            promocodeLabel.leadingAnchor.constraint(equalTo: mainInfoCell.leadingAnchor),
            promocodeLabel.trailingAnchor.constraint(lessThanOrEqualTo: switchButton.leadingAnchor, constant: -80),
            promocodeLabel.topAnchor.constraint(equalTo: mainInfoCell.topAnchor),
            promocodeLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor),
            
            discountLabel.leadingAnchor.constraint(equalTo: promocodeLabel.trailingAnchor, constant: 4),
            discountLabel.topAnchor.constraint(equalTo: mainInfoCell.topAnchor),
            
            infoButton.centerYAnchor.constraint(equalTo: discountLabel.centerYAnchor),
            infoButton.leadingAnchor.constraint(equalTo: discountLabel.trailingAnchor, constant: 4),
            
            switchButton.trailingAnchor.constraint(equalTo: mainInfoCell.trailingAnchor),
            switchButton.centerYAnchor.constraint(equalTo: mainInfoCell.centerYAnchor),
            
            dateLabel.leftAnchor.constraint(equalTo: mainInfoCell.leftAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: mainInfoCell.bottomAnchor),
            
            infoLabel.topAnchor.constraint(equalTo: mainInfoCell.bottomAnchor, constant: 8),
            infoLabel.bottomAnchor.constraint(equalTo: promocodeTableCell.bottomAnchor, constant: -12),
            infoLabel.leftAnchor.constraint(equalTo: promocodeTableCell.leftAnchor, constant: 20),
            infoLabel.rightAnchor.constraint(equalTo: mainInfoCell.rightAnchor, constant: -16)
        ])
    }
}
