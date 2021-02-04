import Foundation

public protocol GetProducts {
    
    func get(completion: @escaping (Result<ProductList, DomainError>) -> Void)
    
}
