import Foundation

func makeDummyRequest() -> URLRequest {
    return URLRequest(url: makeDummyURL())
}

func makeDummyURL() -> URL {
    return URL(string: "https://anyurl.com")!
}

func makeError() -> Error {
    return NSError(domain: "any", code: 0)
}

func makeInvalidData() -> Data {
    return Data("invalid data".utf8)
}

func makeValidData() -> Data {
    return Data("{\"property\":\"value\"}".utf8)
}

func makeHttpResponse(statusCode code: Int = 200) -> HTTPURLResponse {
    return HTTPURLResponse(url: makeDummyURL(), statusCode: code, httpVersion: nil, headerFields: nil)!
}

func makeEmptyData() -> Data {
    return Data()
}
