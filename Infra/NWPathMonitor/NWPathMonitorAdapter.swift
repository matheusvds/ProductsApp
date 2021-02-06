import Foundation
import Network
import Data

public class NWPathMonitorAdapter: Network {
    
    private let monitor: NWPathMonitor
    private var isReachable: Bool = true
    
    public init() {
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            self.isReachable = path.status == .satisfied
        }
        monitor.start(queue: DispatchQueue(label: "Monitor"))
    }
    
    public func networkIsReachable(completion: @escaping (Bool) -> Void) {
        completion(isReachable)
    }
    
}
