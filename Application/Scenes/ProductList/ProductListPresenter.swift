import Foundation
import Domain

protocol ProductListPresentationLogic {
    func presentGetProducts(response: ProductsList.GetProducts.Response)
}

final class ProductListPresenter {
    weak var displayLogic: ProductListDisplayLogic?
}

// MARK: - ProductListPresentationLogic
extension ProductListPresenter: ProductListPresentationLogic {
    
    func presentGetProducts(response: ProductsList.GetProducts.Response) {
        
        switch response.result {
        case .success(let productList):
            
            let viewModel = ProductsList.GetProducts.ViewModel(
                items: productList.products.map {
                            GetProductsViewModel.Item(
                                name: $0.name,
                                image: $0.name,
                                brand: $0.brand,
                                currentPrice: "\($0.currency) \($0.currentPrice)",
                                originalPrice: "\($0.currency) \($0.originalPrice)"
                            )
                }, errorMessage: nil
            )
            
            displayLogic?.displayGetProducts(viewModel: viewModel)
        case .failure(let error):
            
            let viewModel = ProductsList.GetProducts.ViewModel(items: [], errorMessage: error.errorMessage)
            displayLogic?.displayGetProducts(viewModel: viewModel)
            
        }
    }
}

extension DomainError {
    var errorMessage: String {
        switch self {
        case .unexpected:
            return "An unexpected error occurred 👩‍🚒"
        }
    }
}
