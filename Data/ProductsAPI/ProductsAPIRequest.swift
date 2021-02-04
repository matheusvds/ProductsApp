import Foundation

public protocol ProductsAPIRequest {
    
    var method: String { get }
    var resource: ProductsAPIResource { get }
    
}

public extension ProductsAPIRequest {
    
    private var scheme: String {
        return "https"
    }
    
    private var baseURL: String {
        return "private-91dd6-iosassessment.apiary-mock.com"
    }
    
    private var path: String {
        return "/\(resource.rawValue)"
    }
    
    private var serviceURL: URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = baseURL
        components.path = path
        return components.url!
    }
    
    var method: String {
        return "GET"
    }
    
    var request: URLRequest {
        var request = URLRequest(url: serviceURL)
        request.httpMethod = method
        return request
    }
    
}
