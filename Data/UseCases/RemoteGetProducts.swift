import Domain
import Foundation

final public class RemoteGetProducts: GetProducts {
    
    private let httpClient: HttpClient
    
    public init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    public func get(completion: @escaping (Result<ProductList, DomainError>) -> Void) {
        httpClient.send(from: GetProductsRequest().request) { [weak self] in
            guard self != nil else { return }
            switch $0 {
            case .success(let data):
                if let model: ProductList = data?.toModel() {
                    return completion(.success(model))
                }
        
                return completion(.failure(.unexpected))
                
            case .failure:
                return completion(.failure(.unexpected))
            }
        }
    }
    
}
