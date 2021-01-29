import XCTest
import Domain
@testable import Data

class RemoteGetProductsTests: XCTestCase {
    
    func test_get_products_should_not_complete_when_sut_is_deallocated() {
        let httpSpy = HttpClientSpy()
        var sut: RemoteGetProducts? = RemoteGetProducts(httpClient: httpSpy)
        var receivedResult: Result<Products, DomainError>?
        
        sut?.get() { receivedResult = $0 }
        sut = nil
        
        httpSpy.complete(withError: .unauthorized)
        
        XCTAssertNil(receivedResult)
    }
    
}
