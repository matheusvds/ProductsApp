import Foundation
import Domain

protocol ProductListBusinessLogic {
    
    func getProducts(request: ProductsList.GetProducts.Request)
    func saveProducts(request: ProductsList.SaveProducts.Request)
}

protocol ProductListDataStore {
    
}

final class ProductListInteractor: ProductListDataStore {
    
    var presenter: ProductListPresentationLogic?
    
    // MARK: - Use Cases
    let getProductsUseCase: GetProducts
    let getReachbilityUseCase: GetReachbility
    let saveProducts: SaveProducts
    
    init(getProductsUseCase: GetProducts,
         getReachbilityUseCase: GetReachbility,
         saveProducts: SaveProducts) {
        self.getProductsUseCase = getProductsUseCase
        self.getReachbilityUseCase = getReachbilityUseCase
        self.saveProducts = saveProducts
    }
    
}

// MARK: - ProductListBusinessLogic
extension ProductListInteractor: ProductListBusinessLogic {

    func getProducts(request: ProductsList.GetProducts.Request) {
        getReachbilityUseCase.networkIsReachable { [weak self] (reachable) in
            if reachable {
                self?.getProductsUseCase.get { [weak self] in
                    let response = ProductsList.GetProducts.Response(result: $0)
                    self?.presenter?.presentGetProducts(response: response)
                }
            }
        }
    }
    
    func saveProducts(request: ProductsList.SaveProducts.Request) {
        let saveModel = SaveProductsModel(products: request.items)
        saveProducts.save(saveProductsModel: saveModel) {
            switch $0 {
            case .success:
                print("success saving")
            case .failure:
                print("error saving")
            }
        }
    }
    
}
