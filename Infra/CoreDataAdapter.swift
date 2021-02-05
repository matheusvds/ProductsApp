import Foundation
import CoreData
import Data
import SharedModels

public class PersistentContainer: NSPersistentContainer { }

final public class CoreDataAdapter: StorageSave, StorageGet {
    
    
    let container: PersistentContainer
    
    public init(container: PersistentContainer) {
        self.container = container
    }
    
    public func get() -> Result<[ProductItemModel], StorageError> {
        do {
            let request = Product.fetchRequest()
            let products = try container.viewContext.fetch(request) as! [Product]
            
            let model: [ProductItemModel?] = products.map {
                if let name = $0.name,
                   let image = $0.image,
                   let brand = $0.brand,
                   let currentPrice = $0.currentPrice,
                   let originalPrice = $0.originalPrice {
                    
                    return ProductItemModel(
                        name: name,
                        image: image,
                        brand: brand,
                        currentPrice: currentPrice,
                        originalPrice: originalPrice,
                        originalPriceIsHidden: $0.originalPriceIsHidden
                    )
                }
                return nil
            }
            
            return .success(model.compactMap { $0 })
            
        } catch {
            print("\(error)")
            return .failure(.unexpected)
        }
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
                    product.setValue(item.originalPrice, forKey: "originalPrice")
                    product.setValue(item.originalPriceIsHidden, forKey: "originalPriceIsHidden")
                }
                else {
                    let product = Product(context: container.viewContext)
                    product.setValue(item.name, forKey: "name")
                    product.setValue(item.brand, forKey: "brand")
                    product.setValue(item.image, forKey: "image")
                    product.setValue(item.currentPrice, forKey: "currentPrice")
                    product.setValue(item.originalPrice, forKey: "originalPrice")
                    product.setValue(item.originalPriceIsHidden, forKey: "originalPriceIsHidden")
                    
                }
                
                try container.viewContext.save()
            } catch {
                saveError = error
            }
        }
        
        if let _ = saveError {
            return .failure(.unexpected)
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
    @NSManaged public var originalPriceIsHidden: Bool
    
}

extension Product : Identifiable {
    
}
