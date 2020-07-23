//
//  LZ_Head.swift
//  SMHCommerce
//
//  Created by lvzhao on 2020/1/9.
//  Copyright © 2020 lvzhao. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import ReactiveCocoa
import PKHUD


//屏幕的高
let kScreenHeight = UIScreen.main.bounds.height
//屏幕的款
let kScreenWidth = UIScreen.main.bounds.width








/// 服务器地址
let kBase_URL = "http://api"

//是否是iphoneX
func kisPhoneX() -> Bool {
    if #available(iOS 11, *) {
          guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
              return false
          }
          
          if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
              print(unwrapedWindow.safeAreaInsets)
              return true
          }
    }
    return false
}

//tabbar 的高度
let kBarHeight = kisPhoneX() ? 83.0:49.0

//导航栏的高度
let kNavHeight = kisPhoneX() ? 88.0:64.0

//适配屏幕
func kAutoValue(value:Int) -> (CGFloat){
    return CGFloat(value) / 375.0 * kScreenWidth
}





