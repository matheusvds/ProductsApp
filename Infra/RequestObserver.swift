import Foundation

extension URLRequest {
    class Observer {
        static var emit: ((URLRequest) -> Void)?
        static func observe(completion: @escaping (URLRequest) -> Void) {
            URLRequest.Observer.emit = completion
        }
    }
}
