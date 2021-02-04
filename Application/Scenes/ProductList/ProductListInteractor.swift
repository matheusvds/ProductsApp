import Foundation
import Domain

protocol ProductListBusinessLogic {
    
    func getProducts(request: ProductsList.GetProducts.Request)
    
}

protocol ProductListDataStore {
    
}

final class ProductListInteractor: ProductListDataStore {
    
    var presenter: ProductListPresentationLogic?
    
    // MARK: - Use Cases
    let getProductsUseCase: GetProducts
    
    init(getProductsUseCase: GetProducts) {
        self.getProductsUseCase = getProductsUseCase
    }
    
}

// MARK: - ProductListBusinessLogic
extension ProductListInteractor: ProductListBusinessLogic {
    
    func getProducts(request: ProductsList.GetProducts.Request) {
        getProductsUseCase.get { [weak self] in
            let response = ProductsList.GetProducts.Response(result: $0)
            self?.presenter?.presentGetProducts(response: response)
        }
    }
    
}
