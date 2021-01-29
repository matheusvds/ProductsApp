import Foundation
import XCTest

extension Encodable {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
