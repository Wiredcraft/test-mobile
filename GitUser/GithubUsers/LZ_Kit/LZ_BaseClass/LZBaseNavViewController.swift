//
//  LZBaseNavViewController.swift
//  SMHCommerce
//
//  Created by lvzhao on 2020/1/6.
//  Copyright © 2020 lvzhao. All rights reserved.
//

import UIKit

class LZBaseNavViewController: UINavigationController ,UIGestureRecognizerDelegate ,UINavigationControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        self.interactivePopGestureRecognizer?.delegate = self
        self.navigationBar.barStyle = .black
        self.navigationBar.barTintColor = UIColor.white
        self.navigationBar.titleTextAttributes = [.foregroundColor: UIColorFromHex(rgbValue: 0x363636),
                                                  .font:ktextFont(size: 17)]
        self.navigationBar.isTranslucent = false
        self.delegate = self
        
        self.navigationBar.shadowImage = UIImage.init()
        // Do any additional setup after loading the view.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
        
        
    }
    
    
    override func popViewController(animated: Bool) -> UIViewController? {
       return super.popViewController(animated: animated)
    }
    
    //MARK:UIGestureRecognizerDelegate
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view is UISlider) {
            return false
        }
        if self.viewControllers.count == 1 {
            return false
        } else {
            return true
        }
    }
    
    
    //MARK:UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        let appName = Bundle.main.infoDictionary!["CFBundleName"]
        let hiddenNavs : [String] = ["\(appName ?? "").SMHHomeViewController",
                                     "\(appName ?? "").SMHMineViewController"]
        let vcString = NSStringFromClass(type(of: viewController).self)
        var isHiddden = false
        if hiddenNavs .contains(vcString){
            isHiddden = true
        }
        self.setNavigationBarHidden(isHiddden, animated: animated)
        
    }
    
    
    override var childForStatusBarStyle: UIViewController?{
        return self.topViewController
    }
    /*
    // MARK: - Navigation
    



   

     - (UIViewController *)childViewControllerForStatusBarStyle{
         return self.topViewController;
     }
    }
    */

}
