import UIKit

class ProductSelectionViewController: UIViewController {
    private var productSelectionViewModel: ProductSelectionViewModel = ProductSelectionViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(ProductCell.self, forCellReuseIdentifier: String(describing: ProductCell.self))
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Напишите отзыв"
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ProductSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productSelectionViewModel.productData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductCell.self)) as? ProductCell else {
            return UITableViewCell()
        }
        
        let productData = productSelectionViewModel.productData[indexPath.row]
        cell.configure(image: productData.image, title: productData.title, subtitle: productData.subtitle)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newScreen = WriteReviewViewController()
        
        let productData = productSelectionViewModel.productData[indexPath.row]
        
        var temp = WriteReviewViewModel.titleElement.init(number: indexPath.row, image: productData.image, title: productData.title, subtitle: productData.subtitle)
        newScreen.writingComment = temp
        
        navigationController?.pushViewController(newScreen, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
