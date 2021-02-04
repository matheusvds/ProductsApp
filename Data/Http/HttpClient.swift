import Foundation

public protocol HttpClient {
    
    typealias Result = Swift.Result<Data?, HttpError>
    
    func send(from request: URLRequest, completion: @escaping (Result) -> Void)
    
}
