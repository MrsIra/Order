import UIKit

class ButtonAddPhoto: UIButton {
    private enum Constants {
        static let lightGrayColor = UIColor(named: "ColorNewGray")
        static let cloudUpload = UIImage(named: "CloudUpload")
        static let darkGrayColor = UIColor(named: "ColorNewDarkGray")
        static let fontTitle = UIFont(name: "Roboto", size: 14)
        static let fontSubtitle = UIFont(name: "Roboto", size: 12)
        static let textTitle = "Добавьте фото или видео"
        static let textSubtitle = "Нажмите, чтобы выбрать файлы"
    }
    
    var ButtonAddPhotoTapped: (() -> (Void))?
    
    private lazy var addPhotoView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.lightGrayColor
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let cloudImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.cloudUpload
        return imageView
    }()
    
    private lazy var textView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var textTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.textTitle
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = Constants.fontTitle
        return label
    }()
    
    private lazy var textSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.textSubtitle
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = Constants.darkGrayColor
        label.font = Constants.fontSubtitle
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        self.addGestureRecognizer(tapGesture)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func cellTapped() {
        ButtonAddPhotoTapped?()
    }
}

private extension ButtonAddPhoto {
    func addSubviews() {
        addSubview(addPhotoView)
        addPhotoView.addSubview(cloudImageView)
        addPhotoView.addSubview(textView)
        textView.addSubview(textTitleLabel)
        textView.addSubview(textSubtitleLabel)
    }
    
    private func setupConstraints() {
        addPhotoView.translatesAutoresizingMaskIntoConstraints = false
        cloudImageView.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        textSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 80),

            addPhotoView.topAnchor.constraint(equalTo: topAnchor),
            addPhotoView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            addPhotoView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            addPhotoView.bottomAnchor.constraint(equalTo: bottomAnchor),

            cloudImageView.topAnchor.constraint(equalTo: addPhotoView.topAnchor, constant: 28),
            cloudImageView.leftAnchor.constraint(equalTo: addPhotoView.leftAnchor, constant: 16),
            cloudImageView.bottomAnchor.constraint(equalTo: addPhotoView.bottomAnchor, constant: -28),

            textView.topAnchor.constraint(equalTo: addPhotoView.topAnchor, constant: 20),
            textView.leftAnchor.constraint(equalTo: cloudImageView.rightAnchor, constant: 16),
            textView.rightAnchor.constraint(equalTo: addPhotoView.rightAnchor),
            textView.bottomAnchor.constraint(equalTo: addPhotoView.bottomAnchor, constant: -16),

            textTitleLabel.topAnchor.constraint(equalTo: textView.topAnchor),
            textTitleLabel.leftAnchor.constraint(equalTo: textView.leftAnchor),

            textSubtitleLabel.topAnchor.constraint(equalTo: textTitleLabel.bottomAnchor),
            textSubtitleLabel.leftAnchor.constraint(equalTo: textView.leftAnchor)
        ])
    }
}

