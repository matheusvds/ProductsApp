import Foundation
import Domain

typealias GetProductsViewModel = ProductsList.GetProducts.ViewModel

enum ProductsList {
    enum GetProducts {
        
        struct Request {

        }
        
        struct Response {
            let result: Result<Domain.ProductList, DomainError>
        }
        
        struct ViewModel {
            
            let items: [Item]
            let errorMessage: String?
            
            struct Item {
                
                let name: String
                let image: String
                let brand: String
                let currentPrice: String
                let originalPrice: String
            }
        }
    }
}

