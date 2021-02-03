import Foundation
import Domain

enum ProductList {
    enum GetProducts {
        
        struct Request {

        }
        
        struct Response {
            let productList: Result<Domain.ProductList, DomainError>
        }
        
        struct ViewModel {
            let name: String
            let image: String
            let brand: String
            let currentPrice: String
            let originalPrice: String
        }
    }
}

