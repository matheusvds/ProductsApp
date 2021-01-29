import Foundation

extension URLProtocolStub {
    class Observer {
        static var emit: ((URLRequest) -> Void)?
        static func observe(completion: @escaping (URLRequest) -> Void) {
            URLProtocolStub.Observer.emit = completion
        }
    }
}
