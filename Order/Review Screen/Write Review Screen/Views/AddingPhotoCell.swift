import UIKit

class AddingPhotoCell: UITableViewCell {
    private lazy var buttonAddPhoto: ButtonAddPhoto = {
        let button = ButtonAddPhoto()
        return button
    }()
    
    private lazy var collectionView: CollectionViewCell = {
        let collectionView = CollectionViewCell()
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buttonAddPhoto.ButtonAddPhotoTapped = { [weak self] in
            self?.buttonAddPhoto.isHidden = true
            self?.setupCollectionView()
        }
        
        contentView.addSubview(buttonAddPhoto)
        
        buttonAddPhoto.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonAddPhoto.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            buttonAddPhoto.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            buttonAddPhoto.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            buttonAddPhoto.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AddingPhotoCell {
    func setupCollectionView() {
        contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            //            collectionView.heightAnchor.constraint(equalToConstant: 400)
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
