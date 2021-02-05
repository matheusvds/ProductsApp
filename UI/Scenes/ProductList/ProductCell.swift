import Foundation
import UIKit
import SharedModels

class ProductCell: UITableViewCell, ReuseIdentifiable {
        
    lazy var productImage: CircularImageView = {
        let view = CircularImageView()
        view.image = UIImage(named: "image", in: Bundle(for: type(of: self)), with: .none)
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var productName: UITextField = {
        let view = UITextField()
        view.font = UIFont.systemFont(ofSize: 16, weight: .bold)
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
        view.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        return view
    }()
    
    private lazy var stackView: UIStackView = { [weak self] in
        let subviews = [self?.currentPrice, self?.originalPrice].compactMap { $0 }
        let view = UIStackView(arrangedSubviews: subviews)
        view.distribution = .equalSpacing
        view.axis = .vertical
        view.spacing = 5
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    func setup(with model: ProductCellModel) {
        brand.text = model.brand
        productName.text = model.name
        currentPrice.text = model.currentPrice
        originalPrice.attributedText = model.originalPrice.strikeThrough()
        originalPrice.isHidden = model.originalPriceIsHidden
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
        addSubview(stackView)
    }
    
    func buildConstraints() {
        productImage.anchor(top: topAnchor,
                            left: leftAnchor,
                            paddingTop: 5,
                            paddingLeft: 10,
                            paddingBottom: 5,
                            width: 130,
                            height: 130)
        
        productName.anchor(top: productImage.topAnchor,
                            left: productImage.rightAnchor,
                            right: rightAnchor,
                            paddingTop: 20,
                            paddingLeft: 30,
                            paddingRight: 10)
        
        brand.anchor(top: productName.bottomAnchor,
                     left: productName.leftAnchor,
                     paddingTop: 0)
        
        stackView.anchor(top: brand.bottomAnchor,
                         left: brand.leftAnchor,
                         right: rightAnchor,
                         paddingTop: 5)
    }
    
}
