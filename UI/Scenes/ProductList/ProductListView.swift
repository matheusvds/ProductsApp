import Foundation
import UIKit
import SharedModels

public protocol ProductListViewLogic {
    
    var view: UIView { get }
    func set(items: [ProductCellModel])
}

public typealias ProductListViewDelegate = ImageLoadingDelegate & SearchDelegate & ItemListAccessDelegate

public protocol ImageLoadingDelegate: class {
    func set(imageView: UIImageView, with url: String)
}

public protocol SearchDelegate: class {
    func setupInNavigation(controller: UISearchController)
}

public protocol ItemListAccessDelegate: class {
    func get(item: ProductCellModel)
}

public final class ProductListView: UIView {
    
    public weak var delegate: ProductListViewDelegate? {
        didSet {
            delegate?.setupInNavigation(controller: searchController)
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = ProductListTableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.autocapitalizationType = .none
        controller.searchResultsUpdater = self
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "search for products"
        return controller
    }()
    
    private var items: [ProductCellModel] {
        searchController.isActive ? searchedItems : fetchedItems
    }
    
    private var fetchedItems = [ProductCellModel]()
    private var searchedItems = [ProductCellModel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - ProductListViewLogic
extension ProductListView: ProductListViewLogic {
    
    public var view: UIView {
        return self
    }
    
    public func set(items: [ProductCellModel]) {
        self.fetchedItems = items
        DispatchQueue.main.async(execute: tableView.reloadData)
    }
    
}

// MARK: - View Code
extension ProductListView: ViewCode {
    
    func setupHierarchy() {
        addSubview(tableView)
    }
    
    func buildConstraints() {
        tableView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, enableInsets: true)
    }

}

// MARK: - UISearchResultsUpdating
extension ProductListView: UISearchResultsUpdating {
    
    public func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            self.searchedItems = self.fetchedItems.filter { $0.name.lowercased().contains(text.lowercased()) }
        }
        else {
            self.searchedItems = self.fetchedItems
            tableView.reloadData()
        }
        
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension ProductListView: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseIdentifier, for: indexPath) as? ProductCell else {
            return UITableViewCell()
        }
        
        let item = items[indexPath.row]
        cell.setup(with: item)
        delegate?.set(imageView: cell.productImage, with: item.image)
        delegate?.get(item: item)
        return cell
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}
