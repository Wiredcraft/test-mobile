//
//  AppDelegate.swift
//  GithubUsers
//
//  Created by lvzhao on 2020/7/22.
//  Copyright © 2020 吕VV. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow()
        self.window?.backgroundColor = UIColor.white;
        self.window?.frame = UIScreen.main.bounds
        self.window?.makeKeyAndVisible()
               
        //初始化本地数据
        initLocal()
        
        //根视图
        let gitUserVC  = GitUserViewController()
        let rootVC = LZBaseNavViewController.init(rootViewController: gitUserVC)
        self.window?.rootViewController = rootVC
        
        return true
    }

    // MARK: 本地初始化
    func initLocal() {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
}

