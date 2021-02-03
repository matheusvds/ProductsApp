import Foundation
import UIKit

class ProductListTableView: UITableView {
    
    fileprivate lazy var emptyView: UILabel = {
        let emptyView = UILabel()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.font = UIFont.boldSystemFont(ofSize: 30)
        emptyView.isHidden = true
        return emptyView
    }()

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupCells()
        setupAppereance()
        buildEmptyView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func reloadData() {
        super.reloadData()
        addEmptyState()
    }
    
    private func setupCells() {
        register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseIdentifier)
    }
    
    private func setupAppereance() {
        backgroundColor = .systemGray6
        showsVerticalScrollIndicator = false
        separatorStyle = .none
    }
    
    private func addEmptyState() {
        if numberOfRows(inSection: 0) == 0 {
           let message = "Nothing here"
           let emoticon = ["🙈", "🙉", "🙊"].shuffled()[0]
           emptyView.text = "\(message) \(emoticon)"
           emptyView.isHidden = false
            return
        }
        emptyView.isHidden = true
    }
    
    private func buildEmptyView() {
        addSubview(emptyView)
        
        emptyView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        emptyView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -60).isActive = true
    }
}
