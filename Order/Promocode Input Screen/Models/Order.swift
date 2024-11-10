import UIKit

struct Order {
    struct Promocode {
        let id: String
        let title: String
        let percent: Int
        let endDate: Date?
        let info: String?
        var active: Bool
    }

    struct Product {
        let price: Double
        let title: String
    }

    var promocodes: [Promocode]
    let products: [Product]
    let paymentDiscount: Double?
    let baseDiscount: Double?
}
