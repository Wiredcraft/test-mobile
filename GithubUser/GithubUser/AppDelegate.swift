//
//  AppDelegate.swift
//  GithubUser
//
//  Created by zhaitong on 2022/3/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        // 启用
        let navigationVC = NavigationViewController.init(rootViewController: HomeViewController())
        
        self.window?.rootViewController = navigationVC
        self.window?.makeKeyAndVisible()
        return true
    }


}

