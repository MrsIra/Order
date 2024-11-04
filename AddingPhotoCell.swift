import UIKit

class AddPhotoViewModel {
    var images: [String] = []
    let imageNames = ["Image1", "Image2", "Image3", "Image1", "Image2", "Image3", "Image1"]
    var countPhoto: Int = 0
    
    func isEmpty() -> Bool {
        images.isEmpty
    }
    
    func addPhoto() {
        if countPhoto < imageNames.count{
            images.append(imageNames[countPhoto])
            print("Hi \(countPhoto), \(imageNames[countPhoto])")
            countPhoto += 1
        } else {
            return
        }
    }
}

class AddingPhotoCell: UITableViewCell {
    private let viewModel: AddPhotoViewModel = AddPhotoViewModel()
    
    private lazy var buttonAddPhoto: ButtonAddPhoto = {
        let button = ButtonAddPhoto()
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buttonAddPhoto.ButtonAddPhotoTapped = { [weak self] in
//            print("pow")
            self?.viewModel.addPhoto()
        }
        
        contentView.addSubview(buttonAddPhoto)

        buttonAddPhoto.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
//            contentView.heightAnchor.constraint(equalToConstant: 80),

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
