//
//  UIImage+Entensions.swift
//  QRApp
//
//  Created by Ville Välimaa on 18/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import UIKit

public extension UIImage {
    
    func scaled(width: Int, height: Int) -> UIImage {
        return self.scaled(CGSize(width: width, height: height))
    }
    
    func scaled(_ newSize: CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        self.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
