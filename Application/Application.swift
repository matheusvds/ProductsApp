import Foundation
import UIKit
import Domain

public protocol Application {
    func start()
}

public final class Main: Application {
    
    public var window: UIWindow?
    
    let getProducts: GetProducts
    
    public init(getProducts: GetProducts) {
        self.getProducts = getProducts
    }
    
    public func start() {
        let vc = makeProductListViewController()
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigation = UINavigationController(rootViewController: vc)
        window.rootViewController = navigation
        self.window = window
        
        window.makeKeyAndVisible()
    }
    
    
    func makeProductListViewController() -> ProductListViewController {
        
        let presenter = ProductListPresenter()
        let interactor = ProductListInteractor(getProductsUseCase: getProducts)
        let viewController = ProductListViewController(interactor: interactor)
        
        interactor.presenter = presenter
        presenter.displayLogic = viewController
        
        return viewController
    }
    
}
