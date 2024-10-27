import UIKit

class SecondViewController: UIViewController {
    private lazy var labelOne: UILabel = {
        let label = UILabel()
        label.text = "Привет"
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white

        view.addSubview(labelOne)
        labelOne.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            labelOne.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelOne.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
}
