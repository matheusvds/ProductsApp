import Foundation
import Domain

protocol ProductListBusinessLogic {
    func getProducts(request: ProductList.GetProducts.Request)
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
    
    func getProducts(request: ProductList.GetProducts.Request) {
        
        getProductsUseCase.get { [weak self] in
            let response = ProductList.GetProducts.Response(productList: $0)
            self?.presenter?.presentGetProducts(response: response)
        }
    }
}
