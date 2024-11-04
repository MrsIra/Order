import UIKit

class SecondViewController: UINavigationController {
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Применить", for: .normal)
        button.setTitleColor(UIColor(red: 255, green: 255, blue: 255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto", size: 16)
        button.backgroundColor = UIColor(named: "ColorNewTitlePromo")
        button.layer.cornerRadius = 12
        return button
    }()
    
    private lazy var textView: TextFieldCustom = {
        TextFieldCustom()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        navigationBar.isHidden = false
        self.navigationItem.title = "Применить промокод"
        
        view.addSubview(button)
        view.addSubview(textView)
    
        button.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 16),
            textView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            textView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            textView.heightAnchor.constraint(equalToConstant: 54),
            
            button.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 16),
            button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 54),
        ])
        
        
    }
}
