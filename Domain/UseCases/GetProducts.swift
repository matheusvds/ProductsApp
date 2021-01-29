import Foundation

protocol GetProducts {
    func get(completion: @escaping (Result<Product, Error>) -> Void)
}
