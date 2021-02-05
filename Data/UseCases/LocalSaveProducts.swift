import Foundation
import Domain
import SharedModels

final public class LocalSaveProducts: SaveProducts {

    private let storage: StorageSave
    
    public init(storage: StorageSave) {
        self.storage = storage
    }
    
    public func save(saveProductsModel: SaveProductsModel, completion: @escaping (Result<Void, DomainError>) -> Void) {
        let result = storage.save(items: saveProductsModel.products)
        
        switch result {
        case .success:
            return completion(.success(()))
        case .failure:
            return completion(.failure(.unexpected))
        }
    }
    
}
