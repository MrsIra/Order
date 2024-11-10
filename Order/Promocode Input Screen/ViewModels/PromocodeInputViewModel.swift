import Foundation

class PromocodeInputViewModel {
    private var countActivePromocode = 0
    
    var testOrder = Order(
        promocodes: [
            Order.Promocode(id: "1", title: "HELLO", percent: 5, endDate: Date(), info: "Промокод действует на первый заказ в приложении", active: false),
            Order.Promocode(id: "2", title: "4300162112534", percent: 5, endDate: Date(), info: "Скидка на второй заказ", active: false),
            Order.Promocode(id: "3", title: "HELLO", percent: 15, endDate: Date(), info: "Промокод действует на первый заказ в приложении", active: false),
            Order.Promocode(id: "4", title: "4300162112534", percent: 5, endDate: Date(), info: "Скидка на второй заказ", active: false),
            Order.Promocode(id: "5", title: "HELLO", percent: 5, endDate: Date(), info: "Промокод действует на первый заказ в приложении", active: false),
            Order.Promocode(id: "6", title: "4300162112534", percent: 5, endDate: Date(), info: "Скидка на второй заказ", active: false),
            Order.Promocode(id: "7", title: "HELLO", percent: 15, endDate: Date(), info: "Промокод действует на первый заказ в приложении", active: false)
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
    
    var showError: ((String) -> ())?
    
    init(update: ((Order) -> Void)? = nil, showError: ((String) -> ())? = nil) {
        self.update = update
        self.showError = showError
    }
    
    func togglePromo(id: String) {
        if let index = testOrder.promocodes.firstIndex(where: { $0.id == id }) {
            let activeCount = testOrder.promocodes.filter { $0.active }.count
            if testOrder.promocodes[index].active {
                testOrder.promocodes[index].active.toggle()
            } else if activeCount < 2 {
                testOrder.promocodes[index].active.toggle()
            } else {
                showError?("Нельзя активировать более двух промокодов.")
            }
            update?(testOrder)
        }
    }
    
    func totalCalculation(order: Order) -> Result {
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

private extension PromocodeInputViewModel {
    func calculateTotal(order: Order) -> Double {
        var totalSumProducts = 0.0
        var amountProducts: Int = 0
        for product in order.products {
            totalSumProducts += product.price
            amountProducts += 1
        }
        
        return totalSumProducts
    }
}
