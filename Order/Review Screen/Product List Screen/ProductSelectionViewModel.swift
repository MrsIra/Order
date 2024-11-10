import UIKit

class ProductSelectionViewModel {
    private let productImage: [String] = ["Image1", "Image2", "Image3", "Image4"]
    private let productDescription: String = "Золотое плоское обручальное кольцо 4 мм"
    private let decorationSize: String = "Размер 17"
    
    var productData: [(image: UIImage, title: String, subtitle: String)] = []
    
    init() {
        generatingProductData()
    }
    
    private func generatingProductData() {
        for index in 0...productImage.count - 1 {
            let productImage = UIImage(named: productImage[index])!
            productData.append((image: productImage, title: productDescription, subtitle: decorationSize))
        }
    }
}
