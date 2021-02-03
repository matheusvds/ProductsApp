import Foundation
import UIKit

protocol ProductListDisplayLogic: class {
    func displayGetProducts(viewModel: ProductList.GetProducts.ViewModel)
}

final class ProductListViewController: UIViewController {
    let interactor: ProductListBusinessLogic
    
    init(interactor: ProductListBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ProductListDisplayLogic
extension ProductListViewController: ProductListDisplayLogic {
    func displayGetProducts(viewModel: ProductList.GetProducts.ViewModel) {
        
    }
}
