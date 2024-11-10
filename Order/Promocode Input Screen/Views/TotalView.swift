import UIKit

class TotalView: UIView {
    private enum Constants {
        static let title = "Оформление заказа"
        static let productDiscounts = "Скидки"
        static let promocodesHeader = "Промокоды"
        static let paymentMethod = "Способ оплаты"
        static let lineTotal = "Итого"
        static let lightGrayColor = UIColor(named: "ColorNewGray")
        static let newOrangeColor = UIColor(named: "ColorNewTitlePromo")
        static let fontTotalPrice = UIFont(name: "Roboto", size: 18)
        static let fontPrice = UIFont(name: "Roboto", size: 14)
        static let right = -32.0
        static let left = 32.0
        static let padding = 10.0
    }
    
    var result: Result? {
        didSet {
            updateUI()
        }
    }
    
    private lazy var priceProductsHeader: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .clear
        label.font = Constants.fontPrice
        return label
    }()
    
    private lazy var priceProductsValue: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Constants.fontPrice
        return label
    }()
    
    private lazy var productDiscountsHeader: UILabel = {
        let label = UILabel()
        label.text = Constants.productDiscounts
        label.textColor = .black
        label.font = Constants.fontPrice
        return label
    }()
    
    private lazy var productDiscountsValue: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Constants.fontPrice
        return label
    }()
    
    private lazy var promocodesHeader: UILabel = {
        let label = UILabel()
        label.text = Constants.promocodesHeader
        label.textColor = .black
        label.font = Constants.fontPrice
        return label
    }()
    
    private lazy var promocodesValue: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Constants.fontPrice
        return label
    }()
    
    private lazy var paymentMethodHeader: UILabel = {
        let label = UILabel()
        label.text = Constants.paymentMethod
        label.textColor = .black
        label.font = Constants.fontPrice
        return label
    }()
    
    private lazy var paymentMethodValue: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Constants.fontPrice
        return label
    }()
    
    private lazy var lineTotalHeader: UILabel = {
        let label = UILabel()
        label.text = Constants.lineTotal
        label.textColor = .black
        label.font = Constants.fontTotalPrice
        return label
    }()
    
    private lazy var lineTotalValue: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Constants.fontTotalPrice
        return label
    }()
    
    private lazy var checkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitle(Constants.title, for: .normal)
        button.backgroundColor = Constants.newOrangeColor
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 12
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Constants.lightGrayColor
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TotalView {
    func updateUI() {
        guard let result else {
            return
        }
        
        let amountProducts: Int = result.amountProducts % 10
        var declensionWord: String = ""
        
        switch amountProducts {
        case 1:
            declensionWord = "товар"
        case 2, 3, 4:
            declensionWord = "товара"
        default:
            declensionWord = "товаров"
        }
        
        priceProductsHeader.text = "Цена за \(result.amountProducts) \(declensionWord)"
        priceProductsValue.text = "\(result.price)"
        
        if let baseDiscount = result.baseDiscount {
            productDiscountsValue.text = "\(baseDiscount)"
        }
        
        promocodesValue.text = "\(result.promocodesDiscount)"
        
        if let paymentDiscount = result.paymentDiscount {
            paymentMethodValue.text = "\(paymentDiscount)"
        }
        
        lineTotalValue.text = "\(result.price)"
    }
    
    func addSubviews() {
        addSubview(priceProductsHeader)
        addSubview(priceProductsValue)
        
        addSubview(productDiscountsHeader)
        addSubview(productDiscountsValue)
        
        addSubview(promocodesHeader)
        addSubview(promocodesValue)
        
        addSubview(paymentMethodHeader)
        addSubview(paymentMethodValue)
        
        addSubview(lineTotalHeader)
        addSubview(lineTotalValue)
        
        addSubview(checkoutButton)
    }
    
    func setupConstraints() {
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
            priceProductsHeader.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            priceProductsHeader.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.left),
            
            priceProductsValue.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            priceProductsValue.rightAnchor.constraint(equalTo: rightAnchor, constant: Constants.right),
            
            productDiscountsHeader.topAnchor.constraint(equalTo: priceProductsHeader.bottomAnchor, constant: Constants.padding),
            productDiscountsHeader.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.left),
            
            productDiscountsValue.topAnchor.constraint(equalTo: priceProductsValue.bottomAnchor, constant: Constants.padding),
            productDiscountsValue.rightAnchor.constraint(equalTo: rightAnchor, constant: Constants.right),
            
            promocodesHeader.topAnchor.constraint(equalTo: productDiscountsHeader.bottomAnchor, constant: Constants.padding),
            promocodesHeader.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.left),
            
            promocodesValue.topAnchor.constraint(equalTo: productDiscountsValue.bottomAnchor, constant: Constants.padding),
            promocodesValue.rightAnchor.constraint(equalTo: rightAnchor, constant: Constants.right),
            
            paymentMethodHeader.topAnchor.constraint(equalTo: promocodesHeader.bottomAnchor, constant: Constants.padding),
            paymentMethodHeader.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.left),
            
            paymentMethodValue.topAnchor.constraint(equalTo: promocodesValue.bottomAnchor, constant: Constants.padding),
            paymentMethodValue.rightAnchor.constraint(equalTo: rightAnchor, constant: Constants.right),
            
            lineTotalHeader.topAnchor.constraint(equalTo: paymentMethodHeader.bottomAnchor, constant: 32),
            lineTotalHeader.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.left),
            
            lineTotalValue.topAnchor.constraint(equalTo: paymentMethodValue.bottomAnchor, constant: 32),
            lineTotalValue.rightAnchor.constraint(equalTo: rightAnchor, constant: Constants.right),
            
            checkoutButton.topAnchor.constraint(equalTo: lineTotalHeader.bottomAnchor, constant: 16),
            checkoutButton.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.left),
            checkoutButton.rightAnchor.constraint(equalTo: rightAnchor, constant: Constants.right),
            checkoutButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
}
