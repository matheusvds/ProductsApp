import Foundation

public protocol GetReachbility {
    
    func networkIsReachable(completion: @escaping (Bool) -> Void)
    
}
