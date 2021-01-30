import Foundation
import Domain

final class LocalSaveProducts: SaveProducts {
    
    private let storage: StorageSave
    
    public init(storage: StorageSave) {
        self.storage = storage
    }
    
    func save(products: Products, completion: @escaping (Result<Void, DomainError>) -> Void) {
        
        guard let data = try? JSONEncoder().encode(products) else {
            return completion(.failure(.unexpected))
        }
        
        let result = storage.save(entity: data)
        
        switch result {
        case .success:
            return completion(.success(()))
        case .failure:
            return completion(.failure(.unexpected))
        }
    }
}
