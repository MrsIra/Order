import UIKit

class PromocodeInputViewController: UIViewController {
    private enum Constants {
        static let mainTitle = "Оформление заказа"
        static let lightGrayColor = UIColor(named: "ColorNewGray")
    }

    private let promocodeInputViewModel: PromocodeInputViewModel = PromocodeInputViewModel()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()

    private lazy var newView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var intervalView: UIView = {
        let intervalView = UIView()
        intervalView.backgroundColor = Constants.lightGrayColor
        return intervalView
    }()
    
    private lazy var headerView: HeaderView = {
        HeaderView()
    }()
    
    private lazy var applyPromocodeButton: ApplyPromocodeButton = {
        let button = ApplyPromocodeButton()
        return button
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.register(PromocodeCell.self, forCellReuseIdentifier: String(describing: PromocodeCell.self))
        tableView.separatorStyle = .none
        return tableView
    }()

    private lazy var totalView: TotalView = {
        TotalView()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = Constants.mainTitle
        
        promocodeInputViewModel.update = { [weak self] newOrder in
            self?.showOrder(order: newOrder)
        }
        
        promocodeInputViewModel.showError = { [weak self] error in
            self?.showAlert(error: error)
        }

        applyPromocodeButton.onApplyButtonTapped = { [weak self] in
            let secondViewController = SecondViewController()
            self?.navigationController?.pushViewController(secondViewController, animated: true)
        }
        
        addSubviews()
        setupConstraints()
        showOrder(order: promocodeInputViewModel.testOrder)
    }
}

private extension PromocodeInputViewController {
    func showOrder(order: Order) {
        tableView.reloadData()
        totalView.result = promocodeInputViewModel.totalCalculation(order: order)
    }
    
    func addSubviews() {
        view.addSubview(scrollView)

        newView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(newView)

        newView.addSubview(intervalView)
        newView.addSubview(headerView)
        newView.addSubview(applyPromocodeButton)
        newView.addSubview(tableView)
        newView.addSubview(totalView)
    }
    
    func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        newView.translatesAutoresizingMaskIntoConstraints = false
        intervalView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        applyPromocodeButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        totalView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            newView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            newView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            newView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            newView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            newView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            intervalView.topAnchor.constraint(equalTo: newView.topAnchor),
            intervalView.leftAnchor.constraint(equalTo: newView.safeAreaLayoutGuide.leftAnchor),
            intervalView.rightAnchor.constraint(equalTo: newView.safeAreaLayoutGuide.rightAnchor),
            intervalView.heightAnchor.constraint(equalToConstant: 16),
            
            headerView.topAnchor.constraint(equalTo: intervalView.bottomAnchor, constant: 20),
            headerView.leftAnchor.constraint(equalTo: newView.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: newView.rightAnchor),
            
            applyPromocodeButton.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            applyPromocodeButton.leftAnchor.constraint(equalTo: newView.leftAnchor),
            applyPromocodeButton.rightAnchor.constraint(equalTo: newView.rightAnchor),
            applyPromocodeButton.heightAnchor.constraint(equalToConstant: 54),

            tableView.topAnchor.constraint(equalTo: applyPromocodeButton.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: newView.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: newView.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: totalView.topAnchor, constant: -20),
            tableView.heightAnchor.constraint(equalToConstant: 800),
        
            totalView.heightAnchor.constraint(equalToConstant: 300),
            totalView.leftAnchor.constraint(equalTo: newView.leftAnchor),
            totalView.rightAnchor.constraint(equalTo: newView.rightAnchor),
            totalView.bottomAnchor.constraint(equalTo: newView.bottomAnchor)
        ])

    }
    
    func showAlert(error: String) {
        let alert = UIAlertController(title: "Ограничение", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension PromocodeInputViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        promocodeInputViewModel.testOrder.promocodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PromocodeCell.self)) as? PromocodeCell else {
            return UITableViewCell()
        }
        
        cell.promocode = promocodeInputViewModel.testOrder.promocodes[indexPath.row]
        cell.togglePromo = { [weak self] id in
            self?.promocodeInputViewModel.togglePromo(id: id)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = UITableView.automaticDimension
        return height
    }
}
