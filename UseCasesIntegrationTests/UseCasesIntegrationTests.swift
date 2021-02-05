import XCTest
import Domain
import Data
import Infra

class UseCasesIntegrationTests: XCTestCase {

    func test_remote_get_products() {
        let httpClient = URLSessionAdapter()
        let sut = RemoteGetProducts(httpClient: httpClient)
        
        let exp = expectation(description: "wait")
        sut.get {
            switch $0 {
            case .success(let productList):
                XCTAssertFalse(productList.products.isEmpty)
            case .failure:
                XCTFail("expecting success got \($0)")
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 2.0)
    }

}
