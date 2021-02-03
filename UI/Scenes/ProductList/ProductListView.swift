import Foundation
import UIKit

public protocol ProductListViewLogic {
    
    var view: UIView { get }
    func set(items: [ProductCellModel])
    
}

public final class ProductListView: UIView {
    
    private lazy var tableView: UITableView = {
        let tableView = ProductListTableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private var items = [ProductCellModel]()
    
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
        self.items = items
        DispatchQueue.main.async(execute: tableView.reloadData)
    }
    
}


// MARK: - View Code
extension ProductListView: ViewCode {
    
    func setupHierarchy() {
        addSubview(tableView)
    }
    
    func buildConstraints() {
        tableView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }

}

// MARK: - UITableViewDataSource
extension ProductListView: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseIdentifier, for: indexPath) as? ProductCell
        
        let item = items[indexPath.row]
        cell?.setup(with: item)
        
        return cell ?? UITableViewCell()
    }

}
