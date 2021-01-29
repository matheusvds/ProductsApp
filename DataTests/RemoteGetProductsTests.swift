import XCTest
import Domain
@testable import Data

class RemoteGetProductsTests: XCTestCase {
    
    func test_get_products_should_not_complete_when_sut_is_deallocated() {
        let httpSpy = HttpClientSpy()
        var sut: RemoteGetProducts? = RemoteGetProducts(httpClient: httpSpy)
        var receivedResult: Result<ProductList, DomainError>?
        
        sut?.get() { receivedResult = $0 }
        sut = nil
        
        httpSpy.complete(withError: .unauthorized)
        
        XCTAssertNil(receivedResult)
    }
    
    func test_get_products_should_complete_with_success_when_client_completes_with_valid_data() {
        let (sut, httpClientSpy) = makeSut()
        let expectedResult = makeProducts()
        expect(sut, completeWith: .success(expectedResult)) {
            httpClientSpy.complete(withData: expectedResult.toData()!)
        }
    }
    
    func test_get_procuts_should_complete_with_error_when_client_completes_with_invalid_format() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.complete(withData: makeInvalidData())
        })
    }
    
    func test_get_products_should_complete_with_error_when_client_completes_with_not_decodable_valid_data() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.complete(withData: makeValidData())
        })
    }
    
    func test_get_products_should_complete_with_error_when_client_completes_with_unexpected_error() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.complete(withError: .badRequest)
        })
    }
    
    func test_get_products_should_complete_with_error_when_client_completes_with_forbidden_error() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.complete(withError: .forbidden)
        })
    }
    
    func test_get_products_should_complete_with_error_when_client_completes_with_no_connection_error() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.complete(withError: .noConnection)
        })
    }
    
    func test_get_products_should_complete_with_error_when_client_completes_with_server_error() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.complete(withError: .serverError)
        })
    }
    
    func test_get_products_should_complete_with_error_when_client_completes_with_unauthorized_error() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.complete(withError: .unauthorized)
        })
    }
}

extension RemoteGetProductsTests {
    
    func makeSut() -> (RemoteGetProducts, HttpClientSpy) {
        
        let httpSpy = HttpClientSpy()
        let sut = RemoteGetProducts(httpClient: httpSpy)
        checkMemoryLeak(for: sut)
        return (sut, httpSpy)
    }
    
    func expect(_ sut:RemoteGetProducts,
                completeWith expectedResult: Result<ProductList, DomainError>,
                when action: () -> Void,
                file: StaticString = #file, line: UInt = #line) {
        
        let expect = expectation(description: "waiting")
        sut.get { receivedResult in
            
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedResult), .success(let receivedResult)):
                XCTAssertEqual(expectedResult, receivedResult, file: file, line: line)
            default: XCTFail("expecting \(expectedResult), got \(receivedResult)", file: file, line: line)
            }
            
            expect.fulfill()
        }
        
        action()
        wait(for: [expect], timeout: 1.0)
    }

}
