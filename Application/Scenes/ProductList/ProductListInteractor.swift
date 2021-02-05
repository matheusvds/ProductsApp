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
    let saveProductsUseCase: SaveProducts
    let localProductsUseCase: LocalProducts
    
    init(getProductsUseCase: GetProducts,
         getReachbilityUseCase: GetReachbility,
         saveProducts: SaveProducts,
         localProducts: LocalProducts) {
        self.getProductsUseCase = getProductsUseCase
        self.getReachbilityUseCase = getReachbilityUseCase
        self.saveProductsUseCase = saveProducts
        self.localProductsUseCase = localProducts
    }
    
}

// MARK: - ProductListBusinessLogic
extension ProductListInteractor: ProductListBusinessLogic {

    func getProducts(request: ProductsList.GetProducts.Request) {
        getReachbilityUseCase.networkIsReachable { [weak self] (reachable) in
            if reachable {
                self?.getProductsUseCase.get { [weak self] in
                    let response = ProductsList.GetProducts.Response(remoteResult: $0)
                    self?.presenter?.presentGetProducts(response: response)
                }
            }
            else {
                self?.localProductsUseCase.get(completion: { [weak self] in
                    let response = ProductsList.GetProducts.Response(localResult: $0)
                    self?.presenter?.presentGetProducts(response: response)
                })
            }
        }
    }
    
    func saveProducts(request: ProductsList.SaveProducts.Request) {
        let saveModel = SaveProductsModel(products: request.items)
        
        saveProductsUseCase.save(saveProductsModel: saveModel) { [weak self] in
            let response = ProductsList.SaveProducts.Response(result: $0)
            self?.presenter?.presentSaveProducts(response: response)
        }
    }
    
}
