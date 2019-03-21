//
//  UIView+extensions.swift
//  QRCodeTool
//
//  Created by 彭柯柱 on 2019/3/20.
//  Copyright © 2019 彭柯柱. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    var x: CGFloat {
        set {
            var rect = self.frame
            rect.origin.x = newValue
            self.frame = rect
        }
        get {
            return self.frame.origin.x
        }
    }
    
    var y: CGFloat {
        set {
            var rect = self.frame
            rect.origin.y = newValue
            self.frame = rect
        }
        get {
            return self.frame.origin.y
        }
    }
    
    var bottom: CGFloat {
        set {
            self.y = newValue - self.height
        }
        get {
            return self.y + self.height
        }
    }


    var width: CGFloat {
        set {
            var rect = self.frame
            rect.size.width = newValue
            self.frame = rect
        }
        get {
            return self.frame.size.width
        }
    }
    
    var height: CGFloat {
        set {
            var rect = self.frame
            rect.size.height = newValue
            self.frame = rect
        }
        get {
            return self.frame.size.height
        }
    }
    
    var centerX: CGFloat {
        set {
            self.x = newValue - self.width / 2.0
        }
        get {
            return self.x + self.width / 2.0
        }
    }

    var centerY: CGFloat {
        set {
            self.y = newValue - self.height / 2.0
        }
        get {
            return self.y + self.height / 2.0
        }
    }
}



