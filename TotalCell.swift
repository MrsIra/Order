import UIKit

class TotalView: UIView {
    var result: ViewModel.Result? {
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
    
    private lazy var priceProductsValue: UILabel = defaultLabel()

    var defaultLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Roboto", size: 14)
        return label
    }

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
    
    private func setupUI() {
        backgroundColor = UIColor(named: "ColorNewGray")

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
            priceProductsHeader.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            
            priceProductsValue.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            priceProductsValue.rightAnchor.constraint(equalTo: rightAnchor, constant: -32),
            
            productDiscountsHeader.topAnchor.constraint(equalTo: priceProductsHeader.bottomAnchor, constant: 10),
            productDiscountsHeader.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            
            productDiscountsValue.topAnchor.constraint(equalTo: priceProductsValue.bottomAnchor, constant: 10),
            productDiscountsValue.rightAnchor.constraint(equalTo: rightAnchor, constant: -32),

            promocodesHeader.topAnchor.constraint(equalTo: productDiscountsHeader.bottomAnchor, constant: 10),
            promocodesHeader.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            
            promocodesValue.topAnchor.constraint(equalTo: productDiscountsValue.bottomAnchor, constant: 10),
            promocodesValue.rightAnchor.constraint(equalTo: rightAnchor, constant: -32),
            
            paymentMethodHeader.topAnchor.constraint(equalTo: promocodesHeader.bottomAnchor, constant: 10),
            paymentMethodHeader.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            
            paymentMethodValue.topAnchor.constraint(equalTo: promocodesValue.bottomAnchor, constant: 10),
            paymentMethodValue.rightAnchor.constraint(equalTo: rightAnchor, constant: -32),
            
            lineTotalHeader.topAnchor.constraint(equalTo: paymentMethodHeader.bottomAnchor, constant: 32),
            lineTotalHeader.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            
            lineTotalValue.topAnchor.constraint(equalTo: paymentMethodValue.bottomAnchor, constant: 32),
            lineTotalValue.rightAnchor.constraint(equalTo: rightAnchor, constant: -32),
            
            checkoutButton.topAnchor.constraint(equalTo: lineTotalHeader.bottomAnchor, constant: 16),
            checkoutButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            checkoutButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -32),
            checkoutButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
