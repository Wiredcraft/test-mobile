//
//  UIColor+CustomColor.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/11.
//

import UIKit
extension UIColor {
    static var dynamicBlack: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (traits) -> UIColor in
                // Return one of two colors depending on light or dark mode
                return traits.userInterfaceStyle == .dark ?
                    .white : .black
            }
        } else {
            // Same old color used for iOS 12 and earlier
            return .black
        }
    }
}
