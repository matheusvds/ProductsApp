import Foundation
import Domain

func makeProducts() -> ProductList {
    let result: ProductList? = getProductsJSON.data(using: .utf8)?.toModel()
    return result!
}
