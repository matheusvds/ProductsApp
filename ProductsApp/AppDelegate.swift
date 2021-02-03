import UIKit
import Application
import Infra
import Data

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    lazy var app: Application = {
        let httpClient = URLSessionAdapter()
        let remoteGetProducts = RemoteGetProducts(httpClient: httpClient)
        let mainApp = Main(getProducts: remoteGetProducts)
        mainApp.window = self.window
        return mainApp
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        app.start()
        return true
    }
}

