import Foundation
import UIKit

protocol ProductListDisplayLogic: class {
    func displayGetProducts(viewModel: ProductsList.GetProducts.ViewModel)
}

final class ProductListViewController: UIViewController {
    let interactor: ProductListBusinessLogic
    private let tableView: UITableView
    private var items: [GetProductsViewModel.Item]
    
    init(interactor: ProductListBusinessLogic) {
        self.interactor = interactor
        self.tableView = UITableView()
        self.items = []
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        interactor.getProducts(request: ProductsList.GetProducts.Request())
    }
    
    private func setup() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseIdentifier)
    }
}

// MARK: - UITableViewDataSource
extension ProductListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(items.count)
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseIdentifier, for: indexPath) as? ProductCell
        
        cell?.textLabel?.text = items[indexPath.row].name
        
        return cell ?? UITableViewCell()
    }
}

// MARK: - ProductListDisplayLogic
extension ProductListViewController: ProductListDisplayLogic {
    func displayGetProducts(viewModel: ProductsList.GetProducts.ViewModel) {
        self.items.append(contentsOf: viewModel.items)
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - ProductCell
class ProductCell: UITableViewCell, ReuseIdentifiable {
    
    lazy var productImage: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    lazy var currentPrice: UITextField = {
        let view = UITextField()
        return view
    }()
        
    lazy var originalPrice: UITextField = {
        let view = UITextField()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Implementation
extension ProductCell: ViewCode {
    func setupHierarchy() {
        addSubview(productImage)
        addSubview(currentPrice)
        addSubview(originalPrice)
    }
    
    func buildConstraints() {

    }
    
    func additionalConfiguration() {

    }
}
