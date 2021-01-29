import Foundation
import Domain

func makeProducts() -> ProductList {
    let result: ProductList? = getProductsJSON.data(using: .utf8)?.toModel()
    return result!
}

func makeInvalidData() -> Data {
    return Data("invalid data".utf8)
}

func makeValidData() -> Data {
    return Data("{\"property\":\"value\"}".utf8)
}
