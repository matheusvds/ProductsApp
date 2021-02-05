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
    

    
    public init(
        identifier: Int,
        name: String,
        brand: String,
        originalPrice: Double,
        currentPrice: Double,
        currency: String,
        image: Image
    ) {
        self.identifier = identifier
        self.name = name
        self.brand = brand
        self.originalPrice = originalPrice
        self.currentPrice = currentPrice
        self.currency = currency
        self.image = image
    }
    
    public struct Image {
       public let url: String
        
        public init(url: String) {
            self.url = url
        }
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
