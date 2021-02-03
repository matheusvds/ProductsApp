import Foundation

/// Identifiable gives a class a reuseIdentifier based on the Type's name
public protocol ReuseIdentifiable: class {
    static var reuseIdentifier: String { get }
}

public extension ReuseIdentifiable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
