import Foundation
import CoreData

public class Product: NSManagedObject { }

extension Product {
    
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }
    
    @NSManaged public var brand: String?
    @NSManaged public var currentPrice: String?
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var originalPrice: String?
    @NSManaged public var originalPriceIsHidden: Bool
    
}

extension Product : Identifiable {
    
}
