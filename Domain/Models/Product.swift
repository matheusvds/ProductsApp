import Foundation

public typealias Products = [Product]

public struct Product {
    
    public let identifier: Int
    public let name: String
    public let brand: String
    public let originalPrice: Double
    public let currentPrice: Double
    public let currency: String
    public let image: Image
    
    public struct Image {
        let id: Int
        let url: String
    }
}

extension Product: Model {
    
    enum CodingKeys: String, CodingKey {
        
        case originalPrice = "original_price"
        case currentPrice = "current_price"
        case identifier, name,brand, currency, image
    }
}

extension Product.Image: Model {}
