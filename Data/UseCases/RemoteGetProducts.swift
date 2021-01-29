import Domain
import Foundation

final class RemoteGetProducts: GetProducts {
    private let httpClient: HttpClient
    
    public init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    func get(completion: @escaping (Result<Products, DomainError>) -> Void) {
        let productsRequest = GetProductsRequest()
        httpClient.send(from: productsRequest.request) { [weak self] in
            guard self != nil else { return }
            switch $0 {
            case .success(let data):
                if let model: Products = data?.toModel() {
                    return completion(.success(model))
                }
            case .failure:
                return completion(.failure(.unexpected))
            }
        }
    }
    
}
