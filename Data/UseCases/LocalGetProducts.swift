import Foundation
import SharedModels
import Domain

final public class LocalGetProducts: LocalProducts {

    private let storage: StorageGet
    
    public init(storage: StorageGet) {
        self.storage = storage
    }
    
    public func get(completion: @escaping (Result<[ProductItemModel], DomainError>) -> Void) {
        let result = storage.get()
        
        switch result {
        case .success(let items):
            completion(.success(items))
        case .failure:
            return completion(.failure(.unexpected))
        }
    }
    
}
