//
//  UIButton+extension.swift
//  SMHCommerce
//
//  Created by lvzhao on 2020/6/1.
//  Copyright © 2020 lvzhao. All rights reserved.
//

import Foundation
import UIKit


enum ButtonEdgeInsetsStyle {
   case ButtonEdgeInsetsStyleTop // image在上，label在下
   case ButtonEdgeInsetsStyleLeft  // image在左，label在右
   case ButtonEdgeInsetsStyleBottom  // image在下，label在上
   case ButtonEdgeInsetsStyleRight // image在右，label在左
}

extension UIButton {
    func layoutButtonEdgeInsets(style:ButtonEdgeInsetsStyle,space:CGFloat) {
        var labelWidth : CGFloat = 0.0
        var labelHeight : CGFloat = 0.0
        var imageEdgeInset = UIEdgeInsets.zero
        var labelEdgeInset = UIEdgeInsets.zero
        let imageWith = self.imageView?.frame.size.width
        let imageHeight = self.imageView?.frame.size.height
        labelWidth = (self.titleLabel?.intrinsicContentSize.width)!
        labelHeight = (self.titleLabel?.intrinsicContentSize.height)!
//        labelWidth = CGFloat(36)
        switch style {
        case .ButtonEdgeInsetsStyleTop:
            imageEdgeInset = UIEdgeInsets(top: -labelHeight-space/2.0, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInset = UIEdgeInsets(top: 0, left: -imageWith!, bottom: -imageHeight!-space/2.0, right: 0)
        case .ButtonEdgeInsetsStyleLeft:
            imageEdgeInset = UIEdgeInsets(top: 0, left: -space/2.0, bottom: 0, right: space/2.0);
            labelEdgeInset = UIEdgeInsets(top: 0, left: space/2.0, bottom: 0, right: -space/2.0);
        case .ButtonEdgeInsetsStyleBottom:
            imageEdgeInset = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight-space/2.0, right: -labelWidth)
            labelEdgeInset = UIEdgeInsets(top: -imageHeight!-space/2.0, left: -imageWith!, bottom: 0, right: 0)
        case .ButtonEdgeInsetsStyleRight:
        // To Do print("坐标是====\(labelWidth)=====\(space)")
            imageEdgeInset = UIEdgeInsets(top: 0, left: labelWidth+space/2.0, bottom: 0, right: -labelWidth-space/2.0)
            labelEdgeInset = UIEdgeInsets(top: 0, left: -imageWith!-space/2.0, bottom: 0, right: imageWith!+space/2.0)
        }
        self.titleEdgeInsets = labelEdgeInset
        self.imageEdgeInsets = imageEdgeInset
  }
}
