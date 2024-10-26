//
//  ViewController.swift
//  Order
//
//  Created by Ира on 15.10.2024.
//

import UIKit

struct TableViewModel {
    enum ViewModelType {
        struct Promocode {
            let id: String = UUID().uuidString
            let title: String
            let percent: String
            let endDate: String
            let info: String?
            var active: Bool
            let toggle: ((Bool, String) -> Void)?
            
            init(title: String, percent: String, endDate: String, info: String?, active: Bool, toggle: ( (Bool, String) -> Void)? = nil) {
                self.title = title
                self.percent = percent
                self.endDate = endDate
                self.info = info
                self.active = active
                self.toggle = toggle
            }
        }
        
        struct TitleInfo {
            let title: String
            let info: String
        }
        
        struct Result {
            var totalSumProducts: Double
            let amountProducts: Int
            let baseDiscount: Double?
            let paymentDiscount: Double?
            var promocodesDiscount: Double
            let price: Double
        }
        
        struct Button {
            let image: UIImage?
            let title: String?
            let backgroundHexColor: String?
            let titleHexColor: String?
        }
        
        case info(TitleInfo)
        case promocode(Promocode)
        case result(Result)
        case button(Button)
    }
    
    var type: ViewModelType
}

class ViewModel {
    lazy var cellViewModels: [TableViewModel] = []
    
    var testOrder = Order(
//        screenTitle: "Оформление заказа",
        promocodes: [
            Order.Promocode(title: "HELLO", percent: 5, endDate: Date(), info: "Промокод действует на первый заказ в приложении", active: false),
            Order.Promocode(title: "4300162112534", percent: 5, endDate: Date(), info: "По 31 марта", active: false)
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
            Order.Product(price: 20000, title: "Product 3"),
            Order.Product(price: 20000, title: "Product 4"),
            Order.Product(price: 20000, title: "Product 5"),
            Order.Product(price: 20000, title: "Product 6"),
            Order.Product(price: 25000, title: "Product 1"),
            Order.Product(price: 20000, title: "Product 2"),
            Order.Product(price: 20000, title: "Product 3"),
            Order.Product(price: 20000, title: "Product 4"),
            Order.Product(price: 20000, title: "Product 5"),
            Order.Product(price: 20000, title: "Product 6"),
            Order.Product(price: 25000, title: "Product 1"),
            Order.Product(price: 20000, title: "Product 2"),
            Order.Product(price: 20000, title: "Product 3"),
            Order.Product(price: 20000, title: "Product 3")
        ],
        paymentDiscount: 5000,
        baseDiscount: 5000
    )
    
    func togglePromo(value: Bool, id: String) {
        let element = cellViewModels.first(where: { value in
            switch value.type {
            case .promocode(let promo):
                if promo.id == id {
                    return true
                }
            default:
                return false
            }

            return false
        })
    }
}

class ViewController: UIViewController {

    let viewModel = ViewModel()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Оформление заказа"
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
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
        tableView.register(HeaderCell.self, forCellReuseIdentifier: String(describing: HeaderCell.self))
        tableView.register(PromocodeCell.self, forCellReuseIdentifier: String(describing: PromocodeCell.self))
        tableView.register(ButtonPromocode.self, forCellReuseIdentifier: String(describing: ButtonPromocode.self))
        tableView.register(TotalCell.self, forCellReuseIdentifier: String(describing: TotalCell.self))
        tableView.separatorStyle = .none
        return tableView
    }()
    
    func showOrder(order: Order) {
        viewModel.cellViewModels.removeAll()
        
        viewModel.cellViewModels.append(.init(type: .info(.init(title: "Промокоды", info: "На один товар можно применить только один промокод"))))
        viewModel.cellViewModels.append(.init(type: .button(.init(image: UIImage(named: "ImagePromo"), title: "Применить промокод", backgroundHexColor: "ColorNewPromo", titleHexColor: "ColorNewTitlePromo"))))
        
        for promocode in order.promocodes {
            let promoViewModel = TableViewModel.ViewModelType.Promocode(
                title: promocode.title,
                percent: "\(promocode.percent)%",
                endDate: formattedDate(promocode.endDate),
                info: promocode.info,
                active: promocode.active
            )
            viewModel.cellViewModels.append(.init(type: .promocode(promoViewModel)))
        }
    
        var totalSumProducts: Double = 0
        var amountProducts: Int = 0
        var totalPriceOrdered = 0
        
        for product in order.products {
            totalSumProducts += product.price
            amountProducts += 1
        }
        
        let resultViewModel = TableViewModel.ViewModelType.Result(totalSumProducts: totalSumProducts, amountProducts: amountProducts, baseDiscount: order.baseDiscount, paymentDiscount: order.paymentDiscount, promocodesDiscount: 0, price: totalSumProducts)
        
        viewModel.cellViewModels.append(.init(type: .result(resultViewModel)))

        tableView.reloadData()
    }
    
    private func formattedDate(_ date: Date?) -> String {
        guard let date = date else { return "" }
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(headerLabel)
        view.addSubview(intervalView)
        view.addSubview(tableView)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        intervalView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            headerLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            intervalView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            intervalView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            intervalView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            intervalView.heightAnchor.constraint(equalToConstant: 16),
            
            tableView.topAnchor.constraint(equalTo: intervalView.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        showOrder(order: viewModel.testOrder)
    }
    
    @objc func tap() {
        print("tap")
    }
    
    @objc func textFieldChanged() {
        
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
        viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = self.viewModel.cellViewModels[indexPath.row]
        
        switch viewModel.type {
        case .promocode(let promo):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PromocodeCell.self)) as? PromocodeCell else {
                return UITableViewCell()
            }
            cell.viewModel = promo
            cell.selectionStyle = .none
            return cell
        
        case .info(let info):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HeaderCell.self)) as? HeaderCell else {
                return UITableViewCell()
            }
            cell.viewModel = info
            cell.selectionStyle = .none
            return cell
            
        case .result(let result):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TotalCell.self)) as? TotalCell else {
                return UITableViewCell()
            }
            cell.viewModel = result
            cell.selectionStyle = .none
            return cell
            
        case .button(let button):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ButtonPromocode.self)) as? ButtonPromocode else {
                return UITableViewCell()
            }
            
            cell.viewModel = button
            cell.selectionStyle = .none
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
