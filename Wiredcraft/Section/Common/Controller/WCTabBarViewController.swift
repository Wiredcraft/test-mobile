//
//  WCTabBarViewController.swift
//  Wiredcraft
//
//  Created by codeLocker on 2020/6/10.
//  Copyright © 2020 codeLocker. All rights reserved.
//

import UIKit

/*
 WCTabBarViewController is global TabBarController
 child:
    * WCHomeViewController
*/
class WCTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// add Home to tabBarController
        self.addViewController(WCHomeViewController(), title: "Home", normalImageName: "wc_tabbar_github_normal", selectedImageName: "wc_tabbar_github_selected")
    }
    
    ///   add viewController to tabBarController
    /// - Parameters:
    ///   - vc: viewController's instance
    ///   - title: viewController's title
    ///   - normalImageName: the image name for normal status
    ///   - selectedImageName: the image name for selected status
    private func addViewController(_ vc: WCBaseViewController, title: String, normalImageName: String, selectedImageName: String) {
        let item = UITabBarItem.init()
        item.title = title
        let titleFont = UIFont.es_pingFangSC(type: .regular, size: 11)
        
        /// set the title style in different states
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: WCConstants.colors.main, NSAttributedString.Key.font: titleFont], for: .selected)
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.es_hex("#999999"), NSAttributedString.Key.font: titleFont], for: .normal)
        
        /// set the image in different states
        item.image = UIImage.init(named: normalImageName)?.withRenderingMode(.alwaysOriginal)
        item.selectedImage = UIImage.init(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
        
        /// add child
        let nav = WCNavigationController.init(rootViewController: vc)
        nav.tabBarItem = item
        self.addChild(nav)
    }
}
