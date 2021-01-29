import Foundation

public struct Product {
    
    var identifier: Int
    var name: String
    var brand: String
    var originalPrice: UInt
    var currentPrice: UInt
    var currency: String
    var image: String
}

public typealias Products = [Product]

extension Product: Decodable {
    
    enum CodingKeys: String, CodingKey {
        
        case originalPrice = "original_price"
        case currentPrice = "current_price"
        case identifier, name,brand, currency, image
    }
}
