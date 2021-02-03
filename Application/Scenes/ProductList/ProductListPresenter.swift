import Foundation

protocol ProductListPresentationLogic {
    func presentGetProducts(response: ProductList.GetProducts.Response)
}

final class ProductListPresenter {
    weak var displayLogic: ProductListDisplayLogic?
}

// MARK: - ProductListPresentationLogic
extension ProductListPresenter: ProductListPresentationLogic {
    
    func presentGetProducts(response: ProductList.GetProducts.Response) {
        let viewModel = ProductList.GetProducts.ViewModel()
        displayLogic?.displayGetProducts(viewModel: viewModel)
    }
    
}
