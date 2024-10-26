import UIKit

class HeaderCell: UITableViewCell {
    var viewModel: TableViewModel.ViewModelType.TitleInfo? {
        didSet {
            updateView()
        }
    }
    
    private lazy var promocodeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Промокоды"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "HelveticaNeue", size: 24)
        return label
    }()
    
    private lazy var promocodeSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "На один товар можно применить только один промокод"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private func updateView() {
        guard let viewModel else {
            return
        }
        
        promocodeTitleLabel.text = viewModel.title
        promocodeSubtitleLabel.text = viewModel.info
    }
    
    private func setupView() {
        contentView.addSubview(promocodeTitleLabel)
        contentView.addSubview(promocodeSubtitleLabel)
        
        promocodeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        promocodeSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            promocodeTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            promocodeTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            promocodeTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            
            promocodeSubtitleLabel.topAnchor.constraint(equalTo: promocodeTitleLabel.bottomAnchor, constant: 10),
            promocodeSubtitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            promocodeSubtitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            promocodeSubtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

