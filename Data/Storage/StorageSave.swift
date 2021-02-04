import Foundation
import Domain

public protocol StorageSave {
    
    func save(entity: Data) -> Result<Void, DomainError>
    
}
