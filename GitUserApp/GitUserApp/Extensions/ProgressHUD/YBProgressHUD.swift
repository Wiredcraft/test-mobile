//
//  YBProgressHUD.swift
//  GitUserApp
//
//  Created by Rock on 7/22/20.
//  Copyright © 2020 Rock. All rights reserved.
//

import Foundation
import SVProgressHUD

class YBProgressHUD {
    class func initYBProgressHUD() {

        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 14.0))
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
 
    }
    
    class func showSuccess(_ status: String) {
        SVProgressHUD.showSuccess(withStatus: status)
    }
    class func showError(_ status: String) {
        SVProgressHUD.showError(withStatus: status)
    }
    class func showLoading(_ status: String) {
        SVProgressHUD.show(withStatus: status)
    }
    class func showInfo(_ status: String) {
        SVProgressHUD.showInfo(withStatus: status)
    }
    class  func showProgress(_ status: String, _ progress: CGFloat) {
       SVProgressHUD.showProgress(Float(progress), status: status)
    }
    class func dismissHUD(_ delay: TimeInterval = 0) {
        SVProgressHUD.dismiss(withDelay: delay)
    }
   
}
