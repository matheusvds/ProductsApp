import Foundation

public protocol SaveProducts {
    func save(products: Products, completion: @escaping (Result<Void, DomainError>) -> Void)
}

public struct SaveProductsModel {
    public let products: Products
}
