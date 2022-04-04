//
//  UIKit+YUI.swift
//  GitHubUsersList
//
//  Created by YUI on 2022/3/28.
//

#if canImport(UIKit)

import UIKit


//internal extension NSObject {
//  func copyWithArchiver() -> Any? {
//    return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self))!
//  }
//}

internal extension NSObject {

    func getPropertyNames(){

        var outCount:UInt32

        outCount = 0

        let propers:UnsafeMutablePointer<objc_property_t>! =  class_copyPropertyList(self.classForCoder, &outCount)
        let count:Int = Int(outCount);

        print(outCount)

        for i in 0...(count-1) {

            let aPro: objc_property_t = propers[i]
            let proName:String! = String(utf8String: property_getName(aPro));
            print(proName)
        }
    }

    func getMethodNames(){

        var outCount:UInt32

        outCount = 0

        let methods:UnsafeMutablePointer<objc_property_t>! =  class_copyMethodList(self.classForCoder, &outCount)
        let count:Int = Int(outCount);

        print(outCount)

        for i in 0...(count-1) {

            let aMet: objc_property_t = methods[i]
            let methodName:String! = String(utf8String: property_getName(aMet));
            print(methodName)
        }
    }
}

internal extension UIImage {
    
  class func circularClipImage(image: UIImage) -> UIImage {
      
      UIGraphicsBeginImageContextWithOptions(image.size, false, 0.0);
      
      let context = UIGraphicsGetCurrentContext()
      let startEllipseRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
      context?.addEllipse(in: startEllipseRect)
      context?.clip()
      image.draw(in: startEllipseRect)
      let circleImage :UIImage?
      circleImage = UIGraphicsGetImageFromCurrentImageContext()
      
      return circleImage!
  }
}

#endif
