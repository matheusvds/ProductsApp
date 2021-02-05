import UIKit
import Application
import Infra
import Data
import CoreData


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    lazy var app: Application = { [weak self] in
        let httpClient = URLSessionAdapter()
        let database = CoreDataAdapter(container: persistentContainer)
        let remoteGetProducts = RemoteGetProducts(httpClient: httpClient)
        let remoteReachability = RemoteGetReachability(network: NWPathMonitorAdapter())
        let localSaveProducts = LocalSaveProducts(storage: database)
        let localGetProcuts = LocalGetProducts(storage: database)
        
        let mainApp = Main(getProducts: remoteGetProducts,
                           saveProducts: localSaveProducts,
                           localProducts: localGetProcuts,
                           getReachability: remoteReachability)
        
        mainApp.window = self?.window
        return mainApp
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        app.start()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        app.saveContext()
    }

    lazy var persistentContainer: PersistentContainer = {
        let bundles = [Bundle(for: Product.self)]
        let model = NSManagedObjectModel.mergedModel(from: bundles)!
        let container = PersistentContainer(name: "Products", managedObjectModel: model)

        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("\(error.userInfo)")
            }
        }

        return container
    }()
}

