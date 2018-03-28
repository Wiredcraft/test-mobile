//
//  AppDelegate.swift
//  QRApp
//
//  Created by Ville Välimaa on 14/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    /// AppDelegate owns backend and other global services and injects them elsewhere.
    ///
    let backend: Backend
    
    var windowBackgroundColor: UIColor? {
        return UIColor.blue
    }
    
    override init() {
        backend = Backend()
        super.init()
    }
    
    func makeRootViewController() -> UIViewController {
        return UINavigationController(rootViewController: MainViewController(backend: makeBackendService()))
    }
    
    func makeBackendService() -> Backend {
        return Backend()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = self.window else {
            fatalError("UIWindow initialization failed. Application closing...")
        }
        window.rootViewController = makeRootViewController()
        window.makeKeyAndVisible()
        window.backgroundColor = windowBackgroundColor
        return true
    }
}

