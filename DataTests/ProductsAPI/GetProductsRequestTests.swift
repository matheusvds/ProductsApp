import XCTest
import Domain
@testable import Data

class ProductsAPIRequestTests: XCTestCase {
    
    func test_get_products_request_should_have_expected_url() {
        let sut = GetProductsRequest()
        let expectedURL = "https://private-91dd6-iosassessment.apiary-mock.com/products"
        
        XCTAssertEqual(sut.request.url!.absoluteString, expectedURL)
    }
}
