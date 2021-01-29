import Foundation
import Data

class HttpClientSpy: HttpClient {
    
    var requests: [URLRequest] = []
    var completion: ((Result<Data?, HttpError>) -> Void)?
    
    func send(from request: URLRequest, completion: @escaping (HttpClient.Result) -> Void) {
        self.requests.append(request)
        self.completion = completion
    }
    
    func complete(withError error: HttpError) {
        completion?(.failure(error))
    }
    
    func complete(withData data: Data) {
        completion?(.success(data))
    }
    
    func completeWithNilData() {
        completion?(.success(nil))
    }
}
