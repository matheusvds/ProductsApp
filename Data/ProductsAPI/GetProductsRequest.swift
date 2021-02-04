import Foundation

struct GetProductsRequest: ProductsAPIRequest {
    
    var resource: ProductsAPIResource {
        return .products
    }
    
}
