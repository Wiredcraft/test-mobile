//
//  Const.swift
//  QRCodeTool
//
//  Created by 彭柯柱 on 2019/3/18.
//  Copyright © 2019 彭柯柱. All rights reserved.
//

import Foundation
import UIKit

//MARK: common dimension
let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height
let kStatusHeight = CGFloat(kIsFullScreen ? 44 : 20)
let kNavBarHeight = UINavigationController().navigationBar.bounds.size.height + kStatusHeight

var kIsFullScreen: Bool {
    if #available(iOS 11, *) {
        guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
            return false
        }
        
        if unwrapedWindow.safeAreaInsets.bottom > 0 {
            print(unwrapedWindow.safeAreaInsets)
            return true
        }
    }
    return false
}

//MARK: color
let themeColor = UIColor.init(red: 50.0 / 255.0, green: 120.0 / 255.0, blue: 240.0 / 255.0, alpha: 1)

