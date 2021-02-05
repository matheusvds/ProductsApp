import Foundation
import Domain
import SharedModels

public protocol StorageSave {
    
    func save(items: Set<ProductItemModel>) -> Result<Void, StorageError>
    
}
