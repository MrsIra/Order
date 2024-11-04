import UIKit

class ButtonAddPhoto: UIButton {
    var ButtonAddPhotoTapped: (() -> (Void))?
    
    private lazy var addPhotoView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "ColorNewGray")
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let cloudImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "CloudUpload")
        return imageView
    }()
    
    private lazy var textView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var titleLabel2: UILabel = {
        let label = UILabel()
        label.text = "Добавьте фото или видео"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "Roboto", size: 14)
        return label
    }()
    
    private lazy var subtitleLabel2: UILabel = {
        let label = UILabel()
        label.text = "Нажмите, чтобы выбрать файлы"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = UIColor(named: "ColorNewDarkGray")
        label.font = UIFont(name: "Roboto", size: 12)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        self.addGestureRecognizer(tapGesture)
        
        addSubview(addPhotoView)
        addPhotoView.addSubview(cloudImageView)
        addPhotoView.addSubview(textView)
        textView.addSubview(titleLabel2)
        textView.addSubview(subtitleLabel2)

        addPhotoView.translatesAutoresizingMaskIntoConstraints = false
        cloudImageView.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel2.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 80),
//
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

            titleLabel2.topAnchor.constraint(equalTo: textView.topAnchor),
            titleLabel2.leftAnchor.constraint(equalTo: textView.leftAnchor),

            subtitleLabel2.topAnchor.constraint(equalTo: titleLabel2.bottomAnchor),
            subtitleLabel2.leftAnchor.constraint(equalTo: textView.leftAnchor)
        ])
    }
    
    @objc func cellTapped() {
//        print("Ячейка была нажата")
        ButtonAddPhotoTapped?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

