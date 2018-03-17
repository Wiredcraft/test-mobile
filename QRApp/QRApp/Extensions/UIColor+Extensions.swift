//
//  UIColor+Extensions.swift
//  QRApp
//
//  Created by Ville Välimaa on 14/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// The color value from the given (red, green, blue) values,
    /// given in the scale [0, 255].
    ///
    class func colorWithRGB(r: Int, g: Int, b: Int, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }

    class var darkBlue: UIColor {
        return colorWithRGB(r: 46, g: 58, b: 79)
    }
}
