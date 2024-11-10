import UIKit

class CollectionViewCell: UITableViewCell {

    var images: [String] = []
    let imageNames = ["Media1", "Media2", "Media3", "Media4", "Media5", "Media6", "Media7"]
    var availableImages = ["Media1", "Media2", "Media3", "Media4", "Media5", "Media6", "Media7"]
    var maxCountPhoto: Int = 7
    var closure: ((Bool) -> ())?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(ImageCollectionCell.self, forCellWithReuseIdentifier: "ImageCollectionCell")
        collectionView.register(ButtonAddImageCell.self, forCellWithReuseIdentifier: "ButtonAddImageCell")
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            collectionView.heightAnchor.constraint(equalToConstant: 400),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func addImage() {
        guard images.count < maxCountPhoto, !availableImages.isEmpty else { return }
        
        let image = availableImages.removeFirst()
        images.append(image)
        collectionView.reloadData()
        
        if images.count >= maxCountPhoto {
            closure?(true)
        }
    }
    
    @objc private func removeImage(_ sender: UIButton) {
        let image = images.remove(at: sender.tag)
        availableImages.append(image)

        collectionView.reloadData()
        
        if images.count >= maxCountPhoto {
            closure?(true)
        } else {
            closure?(false)
        }
    }
}

extension CollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item < images.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionCell", for: indexPath) as! ImageCollectionCell
            cell.imageView.image = UIImage(named: images[indexPath.item])
            cell.removeButton.tag = indexPath.item
            cell.removeButton.addTarget(self, action: #selector(removeImage(_:)), for: .touchUpInside)
            return cell
        } else {
            let addCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonAddImageCell", for: indexPath) as! ButtonAddImageCell
            
            closure = { [weak self] check in
                if check {
                    addCell.addButton.isHidden = true
                } else {
                    addCell.addButton.isHidden = false
                }
            }
            
            addCell.addButton.addTarget(self, action: #selector(addImage), for: .touchUpInside)
            return addCell
        }
    }
}
