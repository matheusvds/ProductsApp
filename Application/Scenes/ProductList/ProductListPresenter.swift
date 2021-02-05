import Foundation
import Domain
import SharedModels

protocol ProductListPresentationLogic {
    
    func presentGetProducts(response: ProductsList.GetProducts.Response)
    func presentSaveProducts(response: ProductsList.SaveProducts.Response)
}

final class ProductListPresenter {
    
    weak var displayLogic: ProductListDisplayLogic?
    
}

// MARK: - ProductListPresentationLogic
extension ProductListPresenter: ProductListPresentationLogic {
    
    func presentGetProducts(response: ProductsList.GetProducts.Response) {
        switch response.remoteResult {
        case .success(let productList):

            let  viewModel = formatViewModel(from: productList)
            displayLogic?.displayGetProducts(viewModel: viewModel)
        case .failure(let error):
            
            let viewModel = ProductsList.GetProducts.ViewModel(items: [], errorMessage: error.errorMessage)
            displayLogic?.displayGetProducts(viewModel: viewModel)
        
        case .none: break
        }
        
        switch response.localResult {
        case .success(let products):
            let orderedProducts = products.sorted(by: { $0.name < $1.name })
            let viewModel = GetProductsViewModel(items: orderedProducts, errorMessage: nil)
            displayLogic?.displayGetProducts(viewModel: viewModel)
        case .failure(let error):
            let viewModel = ProductsList.GetProducts.ViewModel(items: [], errorMessage: error.errorMessage)
            displayLogic?.displayGetProducts(viewModel: viewModel)
        case .none: break
        }
    }
    
    func presentSaveProducts(response: ProductsList.SaveProducts.Response) {
        switch response.result {
        case .success:
            let viewModel = ProductsList.SaveProducts.ViewModel(message: "success saving")
            displayLogic?.displaySaveProducts(viewModel: viewModel)
        case .failure(let error):
            let viewModel = ProductsList.SaveProducts.ViewModel(message: "error saving: \(error)")
            displayLogic?.displaySaveProducts(viewModel: viewModel)
        }

    }
    
    
    private func formatViewModel(from productList: ProductList) -> ProductsList.GetProducts.ViewModel {
        return ProductsList.GetProducts.ViewModel(
            items: productList.products
                .map {
                    ProductItemModel(
                        name: $0.name,
                        image: $0.image.url,
                        brand: $0.brand,
                        currentPrice: format(price: $0.currentPrice, with: $0.currency),
                        originalPrice: format(price: $0.originalPrice, with: $0.currency),
                        originalPriceIsHidden: $0.currentPrice == $0.originalPrice
                    )
                }.sorted(by: { $0.name < $1.name }),
            errorMessage: nil
        )
        
    }
    
    private func format(price: Double, with currencyCode: String) -> String {
        let formatter = NumberFormatter()
        formatter.currencyCode = currencyCode
        formatter.numberStyle = .currency
        
        let number = NSNumber(value: price)
        return formatter.string(from: number) ?? String()
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
