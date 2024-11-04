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
            Order.Promocode(id: "2", title: "4300162112534", percent: 5, endDate: Date(), info: "Скидка на второй заказ", active: false),
            Order.Promocode(id: "3", title: "HELLO", percent: 15, endDate: Date(), info: "Промокод действует на первый заказ в приложении", active: false),
            Order.Promocode(id: "4", title: "4300162112534", percent: 5, endDate: Date(), info: "Скидка на второй заказ", active: false)
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
            //            print("hello")
            testOrder.promocodes[index].active.toggle()
            update?(testOrder)
        }
    }
    
    private func calculateTotal(order: Order) -> Double {
        var totalSumProducts = 0.0
        var amountProducts: Int = 0
        for product in order.products {
            totalSumProducts += product.price
            amountProducts += 1
        }
        
        return totalSumProducts
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
        
        let result = Result(totalSumProducts: totalSumProducts, amountProducts: amountProducts, baseDiscount: order.baseDiscount, paymentDiscount: order.paymentDiscount, promocodesDiscount: promocodesDiscount, price: price)
        
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
    
    private let viewModel: ViewModel = ViewModel()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var headerView: HeaderView = {
        HeaderView()
    }()
    
    private lazy var totalView: TotalView = {
        TotalView()
    }()
    
    private lazy var buttonPromocode: ButtonPromocode = {
        let buttonPromocode = ButtonPromocode()
        return buttonPromocode
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(PromocodeCell.self, forCellReuseIdentifier: String(describing: PromocodeCell.self))
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var hideButton: UIButton = {
        let hideButton = UIButton()
        hideButton.setTitle("Скрыть промокоды", for: .normal)
        hideButton.setTitleColor(UIColor(named: "ColorNewTitlePromo"), for: .normal)
        hideButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 16)
        hideButton.addTarget(self, action: #selector(hidePromoCodes), for: .touchUpInside)
        return hideButton
    }()
    
    var shouldShowAllCells = true
    
    @objc func hidePromoCodes () {
        shouldShowAllCells = false
        tableView.reloadData()
    }
    
    
//    let
//    let hideButton = UIButton(type: .system)
//    hideButton.setTitle("Скрыть", for: .normal)
//    hideButton.addTarget(self, action: #selector(hideCells), for: .touchUpInside)
//    hideButton.frame = CGRect(x: 15, y: 10, width: footerView.bounds.size.width - 30, height: 30)
//    footerView.addSubview(hideButton)
//    tableView.tableFooterView = footerView
    private func showOrder(order: Order) {
        tableView.reloadData()
        totalView.result = viewModel.totalCalculation(order: order)
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private lazy var intervalView: UIView = {
        let intervalView = UIView()
        intervalView.backgroundColor = UIColor(named: "ColorNewGray")
        return intervalView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = Constants.mainTitle
        
        viewModel.update = { [weak self] newOrder in
            self?.showOrder(order: newOrder)
        }
        
        buttonPromocode.onApplyButtonTapped = { [weak self] in
            let secondViewController = SecondViewController()
            self?.present(secondViewController, animated: true, completion: nil)
        }
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 50))
        
        view.addSubview(scrollView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        
        stackView.addSubview(intervalView)
        stackView.addSubview(headerView)
        stackView.addSubview(buttonPromocode)
        stackView.addSubview(tableView)
        stackView.addSubview(totalView)
        
        //        tableView.isScrollEnabled = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
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
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            intervalView.topAnchor.constraint(equalTo: stackView.topAnchor),
            intervalView.leftAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.leftAnchor),
            intervalView.rightAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.rightAnchor),
            intervalView.heightAnchor.constraint(equalToConstant: 16),
            
            headerView.topAnchor.constraint(equalTo: intervalView.bottomAnchor, constant: 8),
            headerView.leftAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.rightAnchor),
            
            buttonPromocode.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            buttonPromocode.leftAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.leftAnchor),
            buttonPromocode.rightAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.rightAnchor),
            buttonPromocode.heightAnchor.constraint(equalToConstant: 54),
            
            tableView.topAnchor.constraint(equalTo: buttonPromocode.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.rightAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 320),
            
            totalView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            totalView.heightAnchor.constraint(equalToConstant: 300),
            totalView.leftAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.leftAnchor),
            totalView.rightAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.rightAnchor)
        ])
        
        showOrder(order: viewModel.testOrder)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.testOrder.promocodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PromocodeCell.self)) as? PromocodeCell else {
            return UITableViewCell()
        }
        
        cell.promocode = viewModel.testOrder.promocodes[indexPath.row]
        cell.togglePromo = { [weak self] id in
            self?.viewModel.togglePromo(id: id)
        }
        cell.selectionStyle = .none
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//    }
}
