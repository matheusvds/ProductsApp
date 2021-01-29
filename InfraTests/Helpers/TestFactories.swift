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
