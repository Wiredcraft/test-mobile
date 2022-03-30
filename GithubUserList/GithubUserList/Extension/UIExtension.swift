//
//  UIExtension.swift
//  GithubUserList
//
//  Created by zhaotianyang on 2022/3/29.
//

import UIKit

// MARK: - 形状坐标相关
extension UIView {
    
    var x: CGFloat {
        set {
            var frame = self.frame;
            frame.origin.x = newValue;
            self.frame = frame;
        }
        get {
            return self.frame.origin.x
        }
    }
    
    var y: CGFloat {
        set {
            var frame = self.frame;
            frame.origin.y = newValue;
            self.frame = frame;
        }
        get {
            return self.frame.origin.y
        }
    }
    var maxX: CGFloat {
        get {
            return self.frame.origin.x + self.frame.width
        }
    }
    
    var maxY: CGFloat {
        get {
            return self.frame.origin.y + self.frame.height
        }
    }
    
    var centerX: CGFloat {
        set {
            var center = self.center;
            center.x = newValue;
            self.center = center;
        }
        get {
            return self.center.x
        }
    }
    
    var centerY: CGFloat {
        set {
            var center = self.center;
            center.y = newValue;
            self.center = center;
        }
        get {
            return self.center.y
        }
    }
    
    var width: CGFloat {
        set {
            var frame = self.frame;
            frame.size.width = newValue;
            self.frame = frame;
        }
        get {
            return self.frame.size.width
        }
    }
    
    var height: CGFloat {
        set {
            var frame = self.frame;
            frame.size.height = newValue;
            self.frame = frame;
        }
        get {
            return self.frame.size.height
        }
    }
    
    var size: CGSize {
        set {
            var frame = self.frame;
            frame.size = newValue;
            self.frame = frame;
        }
        get {
            return self.frame.size
        }
    }
}

extension UIColor {
  /**
   *  通过16进制数，返回颜色
   */
  class func hexColor(_ hex: UInt32) -> UIColor {
    let r = (hex >> 16) & 0xFF
    let g = (hex >> 8) & 0xFF;
    let b = (hex) & 0xFF;

    return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1)
  }

  class var randomColor:UIColor {
    get{
      return UIColor.init(red: CGFloat(CGFloat(arc4random_uniform(256))/255) , green: CGFloat(CGFloat(arc4random_uniform(256))/255) , blue: CGFloat(CGFloat(arc4random_uniform(256))/255) , alpha: 1)
    }
  }

  class func RGB(_ r: Int, g: Int, b: Int, a: CGFloat = 1.0) -> UIColor{
    let customeColor:UIColor! = UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: a)
    return customeColor
  }

}

