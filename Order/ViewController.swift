//
//  ViewController.swift
//  Order
//
//  Created by Ира on 15.10.2024.
//

import UIKit

class ViewModel {
    struct Result {
        var totalSumProducts: Double
        let amountProducts: Int
        let baseDiscount: Double?
        let paymentDiscount: Double?
        var promocodesDiscount: Double
        var price: Double
    }
    
    var testOrder = Order(
        promocodes: [
            Order.Promocode(id: "1", title: "HELLO", percent: 5, endDate: Date(), info: "Промокод действует на первый заказ в приложении", active: false),
            Order.Promocode(id: "2", title: "4300162112534", percent: 5, endDate: Date(), info: "Скидка на второй заказ", active: false)
        ],
        products: [
            Order.Product(price: 25000, title: "Product 1"),
            Order.Product(price: 20000, title: "Product 2"),
            Order.Product(price: 20000, title: "Product 3"),
            Order.Product(price: 20000, title: "Product 4"),
            Order.Product(price: 20000, title: "Product 5"),
            Order.Product(price: 20000, title: "Product 6"),
            Order.Product(price: 25000, title: "Product 1"),
            Order.Product(price: 20000, title: "Product 2"),
            Order.Product(price: 20000, title: "Product 3")
        ],
        paymentDiscount: 5000,
        baseDiscount: 5000
    )
    
    var update: ((Order) -> ())?
    
    init(update: ((Order) -> Void)? = nil) {
        self.update = update
    }
    
    func togglePromo(id: String) {
        if let index = testOrder.promocodes.firstIndex(where: { $0.id == id }) {
            testOrder.promocodes[index].active.toggle()
            update?(testOrder)
        }
    }
    
    func calculateTotal(order: Order) -> Double {
        var totalSumProducts = 0.0
        var amountProducts: Int = 0
        for product in order.products {
            totalSumProducts += product.price
            amountProducts += 1
        }
        
        return totalSumProducts//; amountProducts
    }
    
    func totalCalculation(order: Order) -> Result {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.selectionStyle = .none
        
        let totalSumProducts = calculateTotal(order: order)
        let amountProducts = order.products.count
        
        var promocodesDiscount: Double = 0.0
        
        for promocode in order.promocodes {
            if promocode.active {
                promocodesDiscount += (totalSumProducts * Double(promocode.percent)) / 100
            }
        }
        
        let price = totalSumProducts - (order.baseDiscount ?? 0) - (order.paymentDiscount ?? 0) - promocodesDiscount
        
        var result = Result(totalSumProducts: totalSumProducts, amountProducts: amountProducts, baseDiscount: order.baseDiscount, paymentDiscount: order.paymentDiscount, promocodesDiscount: promocodesDiscount, price: price)
        
        return result
    }
}

class ViewController: UIViewController {
    enum Constants {
        static let mainTitle = "Оформление заказа"
        static let title = "Промокоды"
        static let subtitle = "На один товар можно применить только один промокод"

        static let promoButtonImage = UIImage(named: "ImagePromo")
        static let promoButtonTitle = "Применить промокод"
        static let promoButtonBgColorName = "ColorNewPromo"
        static let promoButtonTintColorName = "ColorNewTitlePromo"
    }

    let viewModel: ViewModel = ViewModel()
    
    private lazy var scrollView: UIScrollView = {
            let scrollView = UIScrollView()
//        scrollView.backgroundColor = .red
            return scrollView
        }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.mainTitle
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
    }()

    private lazy var headerView: HeaderView = {
        HeaderView()
    }()

    private lazy var totalView: TotalView = {
        TotalView()
    }()
    
    private lazy var buttonPromocode: ButtonPromocode = {
        let buttonPromocode = ButtonPromocode()
        buttonPromocode.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
        return buttonPromocode
    }()
    
    private lazy var intervalView: UIView = {
        let intervalView = UIView()
        intervalView.backgroundColor = UIColor(named: "ColorNewGray")
        return intervalView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
//        tableView.register(HeaderCell.self, forCellReuseIdentifier: String(describing: HeaderCell.self))
        tableView.register(PromocodeCell.self, forCellReuseIdentifier: String(describing: PromocodeCell.self))
//        tableView.register(ButtonPromocode.self, forCellReuseIdentifier: String(describing: ButtonPromocode.self))
//        tableView.register(TotalCell.self, forCellReuseIdentifier: String(describing: TotalCell.self))
        tableView.separatorStyle = .none
        return tableView
    }()
    
    func showOrder(order: Order) {
        tableView.reloadData()
        totalView.result = viewModel.totalCalculation(order: order)
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
//        stackView.backgroundColor = .blue
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        viewModel.update = { [weak self] newOrder in
            self?.showOrder(order: newOrder)
        }
        //view = scrollView
        view.addSubview(scrollView)
        
        scrollView.addSubview(headerLabel)
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        stackView.addSubview(intervalView)
        stackView.addSubview(headerView)
        stackView.addSubview(buttonPromocode)
        stackView.addSubview(tableView)
        stackView.addSubview(totalView)
        
        tableView.isScrollEnabled = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        intervalView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        buttonPromocode.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        totalView.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor),
            stackView.leftAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor),
            
            headerLabel.topAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.topAnchor),
            headerLabel.leftAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.leftAnchor),
            headerLabel.rightAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.rightAnchor),

            intervalView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            intervalView.leftAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.leftAnchor),
            intervalView.rightAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.rightAnchor),
            intervalView.heightAnchor.constraint(equalToConstant: 16),

            headerView.topAnchor.constraint(equalTo: intervalView.bottomAnchor),
            headerView.leftAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.rightAnchor),

            buttonPromocode.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            buttonPromocode.leftAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.leftAnchor),
            buttonPromocode.rightAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.rightAnchor),
            buttonPromocode.heightAnchor.constraint(equalToConstant: 54),

            tableView.topAnchor.constraint(equalTo: buttonPromocode.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: totalView.topAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 320),

//            totalView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            totalView.heightAnchor.constraint(equalToConstant: 300),
            totalView.leftAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.leftAnchor),
            totalView.rightAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.rightAnchor),
            totalView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
        
        showOrder(order: viewModel.testOrder)
    }
    
    @objc private func applyButtonTapped() {
        print("hello")
        present(ViewController(), animated: true)
//        let secondViewController = SecondViewController()
//        navigationController?.pushViewController(secondViewController, animated: true)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.testOrder.promocodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch viewModel.type {
//        case .promocode(let promo):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PromocodeCell.self)) as? PromocodeCell else {
                return UITableViewCell()
            }

            cell.promocode = viewModel.testOrder.promocodes[indexPath.row]
            cell.togglePromo = { [weak self] id in
                self?.viewModel.togglePromo(id: id)
            }
            cell.selectionStyle = .none
            return cell
//        
//        case .info(let info):
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HeaderCell.self)) as? HeaderCell else {
//                return UITableViewCell()
//            }
//            cell.viewModel = info
//            cell.selectionStyle = .none
//            return cell
//            
//        case .result(let result):
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TotalCell.self)) as? TotalCell else {
//                return UITableViewCell()
//            }
//            cell.viewModel = result
//            cell.selectionStyle = .none
//            return cell
//            
//        case .button(let button):
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ButtonPromocode.self)) as? ButtonPromocode else {
//                return UITableViewCell()
//            }
//
//            cell.viewModel = button
//            cell.selectionStyle = .none
//            return cell
//        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
