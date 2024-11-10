import UIKit

class ImageCollectionCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var removeButton: UIButton = {
        let button = UIButton(type: .custom)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        drawCross()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ImageCollectionCell {
    func drawCross() {
        let crossLayer = CAShapeLayer()
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 10, y: 10))
        
        path.move(to: CGPoint(x: 10, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 10))
        
        crossLayer.path = path.cgPath
        crossLayer.strokeColor = UIColor.white.cgColor
        crossLayer.lineWidth = 4.0
        crossLayer.lineCap = .round
        
        removeButton.layer.addSublayer(crossLayer)
    }
    
    func addSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(removeButton)
    }
    
    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            removeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            removeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            removeButton.widthAnchor.constraint(equalToConstant: 10),
            removeButton.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
}
