import Foundation
import UIKit
import UI
import CoreData
import SharedModels

protocol ProductListDisplayLogic: class {
    
    func displayGetProducts(viewModel: ProductsList.GetProducts.ViewModel)
    func displaySaveProducts(viewModel: ProductsList.SaveProducts.ViewModel)

}

final class ProductListViewController: UIViewController {
    
    let interactor: ProductListBusinessLogic
    private let viewLogic: ProductListViewLogic
    private let imageLoader: ImageLoader
    private var items = Set<ProductItemModel>()
    
    init(interactor: ProductListBusinessLogic,
         viewLogic: ProductListViewLogic,
         imageLoader: ImageLoader) {
        self.interactor = interactor
        self.viewLogic = viewLogic
        self.imageLoader = imageLoader
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
        setup()
        interactor.getProducts(request: ProductsList.GetProducts.Request())
    }
    
    private func setup() {
        setupController()
    }
    
    func saveContext() {
        let request = ProductsList.SaveProducts.Request(items: items)
        interactor.saveProducts(request: request)
    }
}

// MARK: - Helpers
extension ProductListViewController {
    
    private func setupTitle() {
        title = "Products"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupController() {
        setupTitle()
        definesPresentationContext = true
    }
    
}

// MARK: - ProductListDisplayLogic
extension ProductListViewController: ProductListDisplayLogic {
    
    func displayGetProducts(viewModel: ProductsList.GetProducts.ViewModel) {
        viewLogic.set(items: viewModel.items)
    }

    func displaySaveProducts(viewModel: ProductsList.SaveProducts.ViewModel) {
        print(viewModel.message)
    }
    
}

// MARK: - ProductListViewDelegate
extension ProductListViewController: ProductListViewDelegate {
    
    func reloadData() {
        interactor.getProducts(request: ProductsList.GetProducts.Request())
    }
    
    func get(item: ProductCellModel) {
        items.insert(item as! ProductItemModel)
    }
    
    func setupInNavigation(controller: UISearchController) {
        navigationItem.searchController = controller
    }
    
    func set(imageView: UIImageView, with url: String) {
        imageLoader.set(imageView: imageView, with: url)
    }
    
}
