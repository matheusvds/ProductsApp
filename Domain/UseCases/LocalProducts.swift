import Foundation
import SharedModels

public protocol LocalProducts {
    
    func get(completion: @escaping (Result<[ProductItemModel], DomainError>) -> Void)
    
}
