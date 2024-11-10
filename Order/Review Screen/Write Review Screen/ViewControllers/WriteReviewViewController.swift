import UIKit

class WriteReviewViewModel {
    struct titleElement {
        var number: Int?
        var image: UIImage?
        var title: String?
        var subtitle: String?
    }
}

class WriteReviewViewController: UIViewController {
    var writingComment = WriteReviewViewModel.titleElement()
    private var numberTableRows = 6
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TitleImageTextCell.self, forCellReuseIdentifier: String(describing: TitleImageTextCell.self))
        tableView.register(GradeCell.self, forCellReuseIdentifier: String(describing: GradeCell.self))
        tableView.register(AddingPhotoCell.self, forCellReuseIdentifier: String(describing: AddingPhotoCell.self))
        tableView.register(ReviewTextCell.self, forCellReuseIdentifier: String(describing: ReviewTextCell.self))
        tableView.register(CheckBoxButtonCell.self, forCellReuseIdentifier: String(describing: CheckBoxButtonCell.self))
        tableView.register(SendFeedbackButtonCell.self, forCellReuseIdentifier: String(describing: SendFeedbackButtonCell.self))
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
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

private extension WriteReviewViewController {
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func showAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension WriteReviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberTableRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TitleImageTextCell.self)) as? TitleImageTextCell else {
                return UITableViewCell()
            }

            cell.configure(image: writingComment.image ?? UIImage(), title: writingComment.title ?? "", subtitle: writingComment.subtitle ?? "")
            cell.selectionStyle = .none
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GradeCell.self)) as? GradeCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
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
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CheckBoxButtonCell.self)) as? CheckBoxButtonCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SendFeedbackButtonCell", for: indexPath) as! SendFeedbackButtonCell
            
            cell.sendButtonAction = { [weak self] in
                guard let starArray = self?.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? GradeCell else {
                    return false
                }
                return starArray.getStarArray()
            }
            
            cell.showError = { [weak self] message in
                self?.showAlert(withMessage: message)
            }

            return cell
        default:
            return UITableViewCell()
        }
    }
}
