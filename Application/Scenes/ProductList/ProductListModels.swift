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
            
            var remoteResult: Result<Domain.ProductList, DomainError>? = nil
            var localResult: Result<[ProductItemModel], DomainError>? = nil
            
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
            let result: Result<Void, DomainError>
            
        }
        
        struct ViewModel {
            let message: String
        }
    }
    
}

