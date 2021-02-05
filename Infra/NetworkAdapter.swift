import Foundation
import Network
import Data

public class NetworkAdapter: Network {
    
    let monitor: NWPathMonitor
    
    public init() {
        monitor = NWPathMonitor()
    }
    
    public func networkIsReachable(completion: @escaping (Bool) -> Void) {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                return completion(true)
            }
            return completion(false)
        }
        monitor.start(queue: DispatchQueue(label: "Monitor"))
    }
}
