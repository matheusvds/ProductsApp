import Domain
import Foundation

final public class RemoteGetReachability: GetReachbility {

    let network: Network
    
    public init(network: Network) {
        self.network = network
    }
    
    public func networkIsReachable(completion: @escaping (Bool) -> Void) {
        return network.networkIsReachable(completion: completion)
    }
    
}
