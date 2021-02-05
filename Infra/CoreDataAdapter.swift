import Foundation
import CoreData
import Data
import SharedModels

public class PersistentContainer: NSPersistentContainer { }

final public class CoreDataAdapter: StorageSave {

    let container: PersistentContainer
    
    public init(container: PersistentContainer) {
        self.container = container
    }
    
    public func save(items: Set<ProductItemModel>) -> Result<Void, StorageError> {
        var saveError: Error?
        items.forEach { item in
            let request = Product.fetchRequest()
            request.predicate = NSPredicate(format: "name == %@", item.name)
            do {
                if let product = try container.viewContext.fetch(request).first as? Product {
                    product.setValue(item.name, forKey: "name")
                    product.setValue(item.brand, forKey: "brand")
                    product.setValue(item.image, forKey: "image")
                    product.setValue(item.currentPrice, forKey: "currentPrice")
                }
                else {
                    let product = Product(context: container.viewContext)
                    product.setValue(item.name, forKey: "name")
                    product.setValue(item.brand, forKey: "brand")
                    product.setValue(item.image, forKey: "image")
                    product.setValue(item.currentPrice, forKey: "currentPrice")
                }

                try container.viewContext.save()
            } catch {
                saveError = error
            }
        }
        if let _ = saveError {
            return .failure(.unexpected)
        }
        
        do {
            let request = Product.fetchRequest()
            let products = try container.viewContext.fetch(request) as! [Product]
            products.forEach { print($0.name!) }
        } catch {
            print("\(error)")
        }
        
        return .success(())
    }
    
}







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

}

extension Product : Identifiable {

}
