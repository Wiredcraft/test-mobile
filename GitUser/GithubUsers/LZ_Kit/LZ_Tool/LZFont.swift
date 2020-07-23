//
//  LZFont.swift
//  SMHCommerce
//
//  Created by lvzhao on 2020/1/9.
//  Copyright © 2020 lvzhao. All rights reserved.
//

import UIKit

///////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                               //
//  字体 UIFont  只列举一种，其他的换名称自己可定义
//                                                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////


/// 方正黑体简体字体定义
/// - Parameter __SIZE__: 字体大小
/// - Returns: UIFont
func ktextFont(size : CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: size)
}


func ktextBoldFont(size : CGFloat) -> UIFont{
    return UIFont.boldSystemFont(ofSize: size)
}

func ktextFoneName(size : CGFloat , name : String) -> UIFont{
    return UIFont.init(name: name, size: size)!
}
