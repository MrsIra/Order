import UIKit


class CircleView: UIView {
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.setFillColor(UIColor.white.cgColor)

        let radius = min(bounds.width, bounds.height) / 2
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        context.addEllipse(in: CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2))

        context.fillPath()
    }
}

class PromocodeCell: UITableViewCell {
    var viewModel: TableViewModel.ViewModelType.Promocode? {
        didSet {
            updateUI()
        }
    }
    
    private lazy var promocodeTableCell: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "ColorNewGray")
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
        label.text = "PromoLabel"
        label.textColor = .black
        label.font = UIFont(name: "Roboto", size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var discountLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: "ColorNewGreen")
        label.text = "0%"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Roboto", size: 12)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()
    
    private lazy var infoButton: UIButton = {
        let button = UIButton()
        if let image = UIImage(named: "ImageInfo") {
            button.setImage(image, for: .normal)
        }
        return button
    }()
    
    private lazy var switchButton: UISwitch = {
        let button = UISwitch()
        button.onTintColor = UIColor(named: "ColorNewTitlePromo")
        button.layer.cornerRadius = button.frame.height / 2
        button.backgroundColor = UIColor(named: "ColorNewDarkGray")
        button.isOn = false
        button.addTarget(self, action: #selector(toggle), for: .valueChanged)
        return button
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto", size: 14)
        label.textColor = UIColor(named: "ColorNewDarkGray")
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Roboto", size: 16)
        label.textColor = UIColor(named: "ColorNewDarkGray")
        return label
    }()
    
    @objc func toggle() {
        guard let viewModel else { return }
        viewModel.toggle?(switchButton.isOn, viewModel.id)
    }
    
    private func updateUI() {
        guard let viewModel else { return }
        
        promocodeLabel.text = viewModel.title
        switchButton.isOn = viewModel.active
        dateLabel.text = viewModel.endDate
        discountLabel.text = viewModel.percent
        
        if let infoText = viewModel.info {
            infoLabel.text = infoText
            infoLabel.isHidden = false
        } else {
            infoLabel.isHidden = true
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(promocodeTableCell)
        contentView.addSubview(circleLeft)
        contentView.addSubview(circleRight)
        contentView.addSubview(mainInfoCell)
        
        promocodeTableCell.translatesAutoresizingMaskIntoConstraints = false
        circleLeft.translatesAutoresizingMaskIntoConstraints = false
        circleRight.translatesAutoresizingMaskIntoConstraints = false
        mainInfoCell.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        contentView.addSubview(promocodeLabel)
        contentView.addSubview(discountLabel)
        contentView.addSubview(infoButton)
        contentView.addSubview(switchButton)
        contentView.addSubview(dateLabel)
        contentView.addSubview(infoLabel)
        
        promocodeLabel.translatesAutoresizingMaskIntoConstraints = false
        discountLabel.translatesAutoresizingMaskIntoConstraints = false
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
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
