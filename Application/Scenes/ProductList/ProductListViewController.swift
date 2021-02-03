import Foundation
import UIKit
import UI

protocol ProductListDisplayLogic: class {
    func displayGetProducts(viewModel: ProductsList.GetProducts.ViewModel)
}

final class ProductListViewController: UIViewController {
    let interactor: ProductListBusinessLogic
    private let viewLogic: ProductListViewLogic
    
    init(interactor: ProductListBusinessLogic,
         viewLogic: ProductListViewLogic) {
        self.interactor = interactor
        self.viewLogic = viewLogic
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = viewLogic.view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.getProducts(request: ProductsList.GetProducts.Request())
    }
    
}

// MARK: - ProductListDisplayLogic
extension ProductListViewController: ProductListDisplayLogic {
    
    func displayGetProducts(viewModel: ProductsList.GetProducts.ViewModel) {
        viewLogic.set(items: viewModel.items)
    }
    
}

