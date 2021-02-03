import Foundation

// MARK: - ProductCell
public protocol ProductCellModel {
    
    var name: String { get }
    var image: String { get }
    var brand: String { get }
    var currentPrice: String { get }
    var originalPrice: NSAttributedString { get }
    var originalPriceIsHidden: Bool { get }
}
