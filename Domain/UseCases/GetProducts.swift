import Foundation

public protocol GetProducts {
    func get(completion: @escaping (Result<Products, DomainError>) -> Void)
}
