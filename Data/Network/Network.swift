import Foundation

public protocol Network {
    
    func networkIsReachable(completion: @escaping (Bool) -> Void)
    
}
