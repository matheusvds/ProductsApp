import Foundation
import UIKit

class ProductCell: UITableViewCell, ReuseIdentifiable {
        
    private lazy var productImage: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage(named: "image", in: Bundle(for: type(of: self)), with: .none)
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .red
        return view
    }()
    
    private lazy var productName: UITextField = {
        let view = UITextField()
        return view
    }()
    
    private lazy var currentPrice: UITextField = {
        let view = UITextField()
        return view
    }()
    
    private lazy var originalPrice: UITextField = {
        let view = UITextField()
        return view
    }()
    
    private lazy var brand: UITextField = {
        let view = UITextField()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    func setup(with model: ProductCellModel) {
        productName.text = model.name
        currentPrice.text = model.currentPrice
        originalPrice.text = model.originalPrice
        brand.text = model.brand
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UI Implementation
extension ProductCell: ViewCode {
    
    func setupHierarchy() {
        addSubview(productImage)
        addSubview(productName)
        addSubview(currentPrice)
        addSubview(originalPrice)
        addSubview(brand)
    }
    
    func buildConstraints() {
        productImage.anchor(top: topAnchor,
                            left: leftAnchor,
                            bottom: bottomAnchor,
                            paddingTop: 5,
                            paddingLeft: 5,
                            paddingBottom: 5,
                            width: frame.size.width/2)
        
        currentPrice.anchor(top: productImage.topAnchor,
                            left: productImage.rightAnchor,
                            bottom: nil,
                            right: rightAnchor,
                            paddingTop: 20,
                            paddingLeft: 10)
    }
    
    func additionalConfiguration() {
        
    }
    
}
