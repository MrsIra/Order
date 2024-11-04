import UIKit

class WritingCommentViewController: UIViewController {
    var number: Int?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TitleImageTextCell.self, forCellReuseIdentifier: String(describing: TitleImageTextCell.self))
        tableView.register(GradeCell.self, forCellReuseIdentifier: String(describing: GradeCell.self))
        tableView.register(AddingPhotoCell.self, forCellReuseIdentifier: String(describing: AddingPhotoCell.self))
        tableView.register(ReviewTextCell.self, forCellReuseIdentifier: String(describing: ReviewTextCell.self))
//        tableView.register(CheckBoxButtonCell.self, forCellReuseIdentifier: String(describing: CheckBoxButtonCell.self))
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Напишите отзыв"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "IconsLeft"), style: .plain, target: self, action: #selector(backButtonTapped))
        view.backgroundColor = .white
        
        setupTableView()
        tableView.reloadData()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
//            tableView.heightAnchor.constraint(equalToConstant: 500)
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func backButtonTapped() {
        print("Hello")
        navigationController?.popViewController(animated: true)
    }
}

extension WritingCommentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension WritingCommentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        viewModel.testOrder.promocodes.count
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TitleImageTextCell.self)) as? TitleImageTextCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GradeCell.self)) as? GradeCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
//            return tableView.dequeueReusableCell(withIdentifier: "GradeCell", for: indexPath) as! GradeCell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AddingPhotoCell.self)) as? AddingPhotoCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ReviewTextCell.self)) as? ReviewTextCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
//        case 4:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CheckBoxButtonCell.self)) as? CheckBoxButtonCell else {
//                return UITableViewCell()
//            }
//            cell.selectionStyle = .none
//            return cell
//            return tableView.dequeueReusableCell(withIdentifier: "ReviewTextCell", for: indexPath) as! ReviewTextCell
        default:
            return UITableViewCell()
        }
    }
}
