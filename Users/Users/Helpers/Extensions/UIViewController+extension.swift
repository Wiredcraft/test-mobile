//
//  UIViewController+extension.swift
//  chbtc
//
//  Created by IvanZeng on 15/11/21.
//  Copyright © 2019年 Gate. All rights reserved.
//

import Foundation
import Toast_Swift

extension UIViewController {

    func showToastWaiting() {
        DispatchQueue.main.async {
            self.view.hideAllToasts(includeActivity: true, clearQueue: true)
            self.view.makeToastActivity(.center)
        }
    }

    func hideToastWaiting() {
        DispatchQueue.main.async {
            self.view.hideToastActivity()
        }
    }

    func showToast(message: String?) {
        if let message = message, message.isEmpty {
            DispatchQueue.main.async {
                self.view.hideAllToasts(includeActivity: true, clearQueue: true)
            }
            return
        }
        DispatchQueue.main.async {
            self.view.hideAllToasts(includeActivity: true, clearQueue: true)
            self.view.makeToast(message, position: .center)
        }
    }
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
          if let navigationController = controller as? UINavigationController {
              return topViewController(controller: navigationController.visibleViewController)
          }
          if let tabController = controller as? UITabBarController {
              if let selected = tabController.selectedViewController {
                  return topViewController(controller: selected)
              }
          }
          if let presented = controller?.presentedViewController {
              return topViewController(controller: presented)
          }
          return controller
      }
}
