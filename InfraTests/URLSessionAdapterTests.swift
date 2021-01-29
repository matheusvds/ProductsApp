import Data
import Infra
import Foundation
import XCTest

class URLSessionAdapterTests: XCTestCase {

    func test_client_should_have_request_with_valid_url() {
        let dummyRequest = makeDummyRequest()
        testRequest(for: dummyRequest) { request in
            XCTAssertEqual(dummyRequest.url, request.url)
        }
    }

}

extension URLSessionAdapterTests {
    
    func makeSut(file: StaticString = #file, line: UInt = #line) -> URLSessionAdapter {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sut = URLSessionAdapter(session: session)
        return sut
    }
    
    func testRequest(for request: URLRequest = makeDummyRequest(), action: @escaping (URLRequest)-> Void) {
        let sut = makeSut()
        let exp = expectation(description: "wait")
        sut.send(from: request) { _ in exp.fulfill() }
        var request: URLRequest?
        URLRequest.Observer.observe { request = $0 }
        wait(for: [exp], timeout: 1.0)
        action(request!)
    }
}
