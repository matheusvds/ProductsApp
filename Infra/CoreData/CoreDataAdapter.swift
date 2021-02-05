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
            do {
                if let product = item.existent(in: container.viewContext) {
                    product.set(with: item)
                }
                else { create(item: item) }
                
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

// MARK: - Helpers
fileprivate extension CoreDataAdapter {
    
    private func create(item: ProductItemModel) {
        let product = Product(context: container.viewContext)
        product.set(with: item)
    }
    
}

fileprivate extension ProductItemModel {
    
    func existent(in context: NSManagedObjectContext) -> Product? {
        let request = Product.fetchRequest()
        request.predicate = Product.createPredicate(for: self.name, brand: self.brand)
        return try? context.fetch(request).first as? Product
    }
    
}

fileprivate extension Product {
    
    class func createPredicate(for name: String, brand: String) -> NSCompoundPredicate {
        return NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "name = %@", name),
            NSPredicate(format: "brand = %@", brand)
        ])
    }
    
    func set(with item: ProductItemModel) {
        setValue(item.name, forKey: "name")
        setValue(item.brand, forKey: "brand")
        setValue(item.image, forKey: "image")
        setValue(item.currentPrice, forKey: "currentPrice")
        setValue(item.originalPrice, forKey: "originalPrice")
        setValue(item.originalPriceIsHidden, forKey: "originalPriceIsHidden")
    }
    
}

fileprivate extension Optional where Wrapped == Product {
    func set(with item: ProductItemModel) {
        self?.set(with: item)
    }
}
