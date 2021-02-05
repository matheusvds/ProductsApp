import Foundation
import Domain
import SharedModels

public protocol StorageGet {
    
    func get() -> Result<[ProductItemModel], StorageError>
    
}
