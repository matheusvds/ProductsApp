import Foundation

func makeDummyRequest() -> URLRequest {
    return URLRequest(url: makeDummyURL())
}

func makeDummyURL() -> URL {
    return URL(string: "https://anyurl.com")!
}
