import Foundation

// MARK: - ProductCell
public protocol ProductCellModel {
    
    var name: String { get }
    var image: String { get }
    var brand: String { get }
    var currentPrice: String { get }
    var originalPrice: String { get }
    var originalPriceIsHidden: Bool { get }
    
}

public struct ProductItemModel: ProductCellModel, Hashable {
    
    public let name: String
    public let image: String
    public let brand: String
    public let currentPrice: String
    public let originalPrice: String
    public let originalPriceIsHidden: Bool
    
    public init(
        name: String,
        image: String,
        brand: String,
        currentPrice: String,
        originalPrice: String,
        originalPriceIsHidden: Bool
    ) {
        self.name = name
        self.image = image
        self.brand = brand
        self.currentPrice = currentPrice
        self.originalPrice = originalPrice
        self.originalPriceIsHidden = originalPriceIsHidden
    }
    
}
