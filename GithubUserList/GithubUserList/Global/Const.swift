//
//  Const.swift
//  GithubUserList
//
//  Created by zhaotianyang on 2022/3/28.
//

import UIKit

struct Const {
    struct Device {
        static let ScreenSize = UIScreen.main.bounds.size  // 屏幕Size
        static let ScreenW = ScreenSize.width  // 屏幕宽
        static let ScreenH = ScreenSize.height  // 屏幕高
        
        static var StatusBarH: CGFloat {  // 状态栏高度
            let screen = UIApplication.shared.windows.first?.windowScene
            return screen?.statusBarManager?.statusBarFrame.size.height ?? 0
        }

        static let NavigationBarH: CGFloat = 44  // 屏幕高
        
        static var isNotchScreen: Bool {  // 是否是刘海屏
            let notchValue: Int = Int(ScreenW / ScreenH * 100)
            if 216 == notchValue || 46 == notchValue {
                return true
            }
            return false
        }
        
        static let TopSafeH: CGFloat = isNotchScreen ? 44 : 0  // 顶部安全距离高
        static let BottomSafeH: CGFloat = isNotchScreen ? 34 : 0  // 底部安全距离高
        
        static let TabBarH: CGFloat = 49  // Tabbar高
    }
}
