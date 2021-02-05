import Foundation
import UIKit
import Domain
import UI
import CoreData

public protocol Application {
    
    func start()
    func saveContext()
}
class PersistentContainer: NSPersistentContainer { }

public final class Main: Application {
    
    public var window: UIWindow?
    
    let getProducts: GetProducts
    let getReachability: GetReachbility
    let saveProducts: SaveProducts
    private var viewController: ProductListViewController?
    
    public init(getProducts: GetProducts,
                saveProducts: SaveProducts,
                getReachability: GetReachbility) {
        self.getProducts = getProducts
        self.saveProducts = saveProducts
        self.getReachability = getReachability
    }
    
    public func start() {
        let vc = makeProductListViewController()
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigation = UINavigationController(rootViewController: vc!)
        window.rootViewController = navigation
        self.window = window
        
        window.makeKeyAndVisible()
    }
    
    
    func makeProductListViewController() -> ProductListViewController? {
        let presenter = ProductListPresenter()
        let interactor = ProductListInteractor(getProductsUseCase: getProducts,
                                               getReachbilityUseCase: getReachability,
                                               saveProducts: saveProducts)
        let view = ProductListView()
        viewController = ProductListViewController(interactor: interactor,
                                                       viewLogic: view,
                                                       imageLoader: UIImageLoader())
        
        view.delegate = viewController
        interactor.presenter = presenter
        presenter.displayLogic = viewController
        
        return viewController
    }
    
    public func saveContext() {
        print("saving context")
        viewController?.saveContext()
    }
    
}
