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

            let  viewModel = formatViewModel(from: productList)
            displayLogic?.displayGetProducts(viewModel: viewModel)
        case .failure(let error):
            
            let viewModel = ProductsList.GetProducts.ViewModel(items: [], errorMessage: error.errorMessage)
            displayLogic?.displayGetProducts(viewModel: viewModel)
            
        }
    }
    
    private func formatViewModel(from productList: ProductList) -> ProductsList.GetProducts.ViewModel {
        return ProductsList.GetProducts.ViewModel(
            items: productList.products.map {
                        GetProductsViewModel.Item(
                            name: $0.name,
                            image: $0.image.url,
                            brand: $0.brand,
                            currentPrice: format(price: $0.currentPrice, with: $0.currency),
                            originalPrice: format(price: $0.originalPrice, with: $0.currency).strikeThrough(),
                            originalPriceIsHidden: $0.currentPrice == $0.originalPrice
                        )
            }, errorMessage: nil
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
