import Foundation
import SharedModels

public protocol SaveProducts {
    
    func save(saveProductsModel: SaveProductsModel, completion: @escaping (Result<Void, DomainError>) -> Void)
    
}

public struct SaveProductsModel {
    
    public let products: Set<ProductItemModel>
    
    public init (products: Set<ProductItemModel>) {
        self.products = products
    }
    
}
