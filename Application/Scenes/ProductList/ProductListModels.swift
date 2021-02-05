import Foundation
import Domain
import UI
import SharedModels

typealias GetProductsViewModel = ProductsList.GetProducts.ViewModel

enum ProductsList {
    
    enum GetProducts {
        
        struct Request {

        }
        
        struct Response {
            
            let result: Result<Domain.ProductList, DomainError>
            
        }
        
        struct ViewModel {
            
            let items: [ProductItemModel]
            let errorMessage: String?
            
        }
    }
    
    enum SaveProducts {
        
        struct Request {
            let items: Set<ProductItemModel>
        }
        
        struct Response {
            
            
        }
        
        struct ViewModel {

        }
    }
    
}

