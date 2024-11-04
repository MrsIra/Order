import UIKit

class CommentViewModel {
    private let productImage: [String] = ["Image1", "Image2", "Image3", "Image4"]
    private let productDescription = "Золотое плоское обручальное кольцо 4 мм"
    
    var items: [(image: UIImage, text: String)] = []

    init() {
        generateRandomItems()
    }
    
    private func generateRandomItems() {
        for index in 0...productImage.count - 1 {
            let image = UIImage(named: productImage[index])!
            items.append((image: image, text: productDescription))
        }
    }
}

class CommentViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(CommentCell.self, forCellReuseIdentifier: String(describing: CommentCell.self))
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var commentViewModel = CommentViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
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

extension CommentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        commentViewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CommentCell.self)) as? CommentCell else {
            return UITableViewCell()
        }
        
        let item = commentViewModel.items[indexPath.row]
        cell.configure(image: item.image, text: item.text)
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = WritingCommentViewController()
        detailVC.number = indexPath.row + 1 // Передача номера строки
        navigationController?.pushViewController(detailVC, animated: true)
//
//        if let cell = tableView.cellForRow(at: indexPath) {
//            //            cell.backgroundColor = .blue
//            print("Выбран элемент")
//            //            tableView.deselectRow(at: indexPath, animated: true)
//        }
//        //        tableView.deselectRow(at: indexPath, animated: true)
    }
}
