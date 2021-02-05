import Foundation

public struct ProductList: Model {
    
    public let products: Products
    
    public init(products: Products) {
        self.products = products
    }
    
}
