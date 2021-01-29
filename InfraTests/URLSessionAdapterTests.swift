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

    func test_client_should_complete_with_error_when_request_completes_with_error() {
        expect(result: .failure(.noConnection), when: (data: nil, response: nil, error: makeError()))
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
        URLProtocolStub.Observer.observe { request = $0 }
        wait(for: [exp], timeout: 1.0)
        action(request!)
    }
    
    func expect(result expectedResult: Result<Data?, HttpError>, when stub: (data: Data?, response: HTTPURLResponse?, error: Error?), file: StaticString = #file, line: UInt = #line) {
        let sut = makeSut()
        URLProtocolStub.simulate(data: stub.data, response: stub.response, error: stub.error)
        let exp = expectation(description: "wait")
        sut.send(from: makeDummyRequest()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedData), .success(let receivedData)):
                XCTAssertEqual(expectedData, receivedData, file: file, line: line)
            default: XCTFail("expecting \(expectedResult) got \(receivedResult)", file: file, line: line)
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
}
