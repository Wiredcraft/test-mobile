//
//  Utils.swift
//  QRCodeTool
//
//  Created by 彭柯柱 on 2019/3/17.
//  Copyright © 2019 彭柯柱. All rights reserved.
//

import Foundation
import UIKit

var layoutSubViewsCallbackKey = "layoutSubViewsCallbackKey"

extension UIView {
    
    var layoutSubViewsCallback: () -> Void {
        get {
            return objc_getAssociatedObject(self, layoutSubViewsCallbackKey) as! () -> Void
        }
        set {
            objc_setAssociatedObject(self, layoutSubViewsCallbackKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
}
