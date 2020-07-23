//
//  UIScrollView+extension.swift
//  SMHCommerce
//
//  Created by lvzhao on 2020/6/4.
//  Copyright © 2020 lvzhao. All rights reserved.
//

import Foundation
import UIKit


extension UIScrollView {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
        //    [[self nextResponder] touchesBegan:touches withEvent:event];
        self.next?.touchesBegan(touches, with: event)
    }
    
    
    
    
    open override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if self.panBack(gestureRecognizer){
            return false
        }
        return true
    }
    
    func panBack(_ gestureRecognizer: UIGestureRecognizer?) -> Bool {
        //是滑动返回距左边的有效长度
        let location_X = Int(0.15 * kScreenWidth)
        if gestureRecognizer == panGestureRecognizer {
            let pan = gestureRecognizer as? UIPanGestureRecognizer
            let point = pan?.translation(in: self)
            let state = gestureRecognizer?.state
            if .began == state || .possible == state {
                let location = gestureRecognizer?.location(in: self)
                //这是允许每张图片都可实现滑动返回
                let temp1 = Int(location?.x ?? 0)
                let temp2 = kScreenWidth
                let XX = temp1 % Int(temp2)
                if (point?.x ?? 0.0) > 0 && XX < location_X {
                    return true
                }
                
                //下面的是只允许在第一张时滑动返回生效
                //if (point.x > 0 && location.x < location_X && self.contentOffset.x <= 0) {
                //   return true
                //}
            }
        }
        return false

    }
    
    
    
}
