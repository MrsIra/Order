import UIKit

class TotalCell: UITableViewCell {
    var viewModel: TableViewModel.ViewModelType.Result? {
        didSet {
            updateUI()
        }
    }
    
    private lazy var priceProductsHeader: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .clear
        label.font = UIFont(name: "Roboto", size: 14)
        return label
    }()
    
    private lazy var priceProductsValue: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Roboto", size: 14)
        return label
    }()
    
    private lazy var productDiscountsHeader: UILabel = {
        let label = UILabel()
        label.text = "Скидки"
        label.textColor = .black
        label.font = UIFont(name: "Roboto", size: 14)
        return label
    }()
    
    private lazy var productDiscountsValue: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Roboto", size: 14)
        return label
    }()
    
    private lazy var promocodesHeader: UILabel = {
        let label = UILabel()
        label.text = "Промокоды"
        label.textColor = .black
//        label.backgroundColor = UIColor(named: "ColorNewGray")
        label.font = UIFont(name: "Roboto", size: 14)
        return label
    }()
    
    private lazy var promocodesValue: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Roboto", size: 14)
        return label
    }()
    
    private lazy var paymentMethodHeader: UILabel = {
        let label = UILabel()
        label.text = "Способ оплаты"
        label.textColor = .black
        label.font = UIFont(name: "Roboto", size: 14)
        return label
    }()
    
    private lazy var paymentMethodValue: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Roboto", size: 14)
        return label
    }()
    
    private lazy var lineTotalHeader: UILabel = {
        let label = UILabel()
        label.text = "Итого"
        label.textColor = .black
        label.font = UIFont(name: "Roboto", size: 18)
        return label
    }()
    
    private lazy var lineTotalValue: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Roboto", size: 18)
        return label
    }()
    
    private lazy var checkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Оформление заказа", for: .normal)
        button.backgroundColor = UIColor(named: "ColorNewTitlePromo")
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 12
        return button
    }()
    
    private func updateUI() {
        guard let viewModel else {
            return
        }
        
        let amountProducts: Int = viewModel.amountProducts % 10
        var declensionWord: String = ""
        
        switch amountProducts {
        case 1:
            declensionWord = "товар"
        case 2, 3, 4:
            declensionWord = "товара"
        default:
            declensionWord = "товаров"
        }
        
        priceProductsHeader.text = "Цена за \(viewModel.amountProducts) \(declensionWord)"
        priceProductsValue.text = "\(viewModel.price)"
        
        if let baseDiscount = viewModel.baseDiscount {
            productDiscountsValue.text = "\(baseDiscount)"
        }
        
        promocodesValue.text = "\(viewModel.promocodesDiscount)"
        
        if let paymentDiscount = viewModel.paymentDiscount {
            paymentMethodValue.text = "\(paymentDiscount)"
        }
        let total: Double = viewModel.price - ((viewModel.baseDiscount ?? 0) + (viewModel.paymentDiscount ?? 0))
        lineTotalValue.text = "\(total)"
    }
    
    private func setupUI() {
        contentView.backgroundColor = UIColor(named: "ColorNewGray")
        
        contentView.addSubview(priceProductsHeader)
        contentView.addSubview(priceProductsValue)
        
        contentView.addSubview(productDiscountsHeader)
        contentView.addSubview(productDiscountsValue)
        
        contentView.addSubview(promocodesHeader)
        contentView.addSubview(promocodesValue)
        
        contentView.addSubview(paymentMethodHeader)
        contentView.addSubview(paymentMethodValue)
        
        contentView.addSubview(lineTotalHeader)
        contentView.addSubview(lineTotalValue)
        
        contentView.addSubview(checkoutButton)
        
        priceProductsHeader.translatesAutoresizingMaskIntoConstraints = false
        priceProductsValue.translatesAutoresizingMaskIntoConstraints = false
        
        productDiscountsHeader.translatesAutoresizingMaskIntoConstraints = false
        productDiscountsValue.translatesAutoresizingMaskIntoConstraints = false
        
        promocodesHeader.translatesAutoresizingMaskIntoConstraints = false
        promocodesValue.translatesAutoresizingMaskIntoConstraints = false
        
        paymentMethodHeader.translatesAutoresizingMaskIntoConstraints = false
        paymentMethodValue.translatesAutoresizingMaskIntoConstraints = false
        
        lineTotalHeader.translatesAutoresizingMaskIntoConstraints = false
        lineTotalValue.translatesAutoresizingMaskIntoConstraints = false
        
        checkoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            priceProductsHeader.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            priceProductsHeader.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            
            priceProductsValue.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            priceProductsValue.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
            
            productDiscountsHeader.topAnchor.constraint(equalTo: priceProductsHeader.bottomAnchor, constant: 10),
            productDiscountsHeader.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            
            productDiscountsValue.topAnchor.constraint(equalTo: priceProductsValue.bottomAnchor, constant: 10),
            productDiscountsValue.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
            
            promocodesHeader.topAnchor.constraint(equalTo: productDiscountsHeader.bottomAnchor, constant: 10),
            promocodesHeader.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            
            promocodesValue.topAnchor.constraint(equalTo: productDiscountsValue.bottomAnchor, constant: 10),
            promocodesValue.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
            
            paymentMethodHeader.topAnchor.constraint(equalTo: promocodesHeader.bottomAnchor, constant: 10),
            paymentMethodHeader.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            
            paymentMethodValue.topAnchor.constraint(equalTo: promocodesValue.bottomAnchor, constant: 10),
            paymentMethodValue.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
            
            lineTotalHeader.topAnchor.constraint(equalTo: paymentMethodHeader.bottomAnchor, constant: 32),
            lineTotalHeader.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            
            lineTotalValue.topAnchor.constraint(equalTo: paymentMethodValue.bottomAnchor, constant: 32),
            lineTotalValue.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
            
            checkoutButton.topAnchor.constraint(equalTo: lineTotalValue.bottomAnchor, constant: 16),
            checkoutButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            checkoutButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
            checkoutButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
