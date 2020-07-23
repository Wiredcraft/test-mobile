//
//  UIView+Gradient.swift
//  SMHCommerce
//
//  Created by lvzhao on 2020/6/1.
//  Copyright © 2020 lvzhao. All rights reserved.
//

import Foundation
import UIKit


enum ViewGradientStyle{
    
    case ViewGradientStyleLeft  //从左向右
    case ViewGradientStyleTop   //从上到下
    case ViewGradientStyleTopLeft   //从上左
    case ViewGradientStyleBottomLeft   //从下左

    
}

extension UIView {
    
    func layoutViewGradient(style:ViewGradientStyle,colors:Array<CGColor>?) {

        //获取按钮的坐标
        self.layoutIfNeeded()
        print(self.frame)
            
        let viewFrame = self.frame
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 0, width: viewFrame.width, height: viewFrame.height)//按钮所在区域


        var cgColors = colors
        if  cgColors == nil{
             cgColors = [UIColorFromHex(rgbValue: 0xFFA61B).cgColor,
                        UIColorFromHex(rgbValue: 0xFF661B).cgColor]
        }
        

        
        layer.colors = cgColors

        switch style {
        case .ViewGradientStyleLeft:
            layer.startPoint = CGPoint(x: 0, y: 0)
            layer.endPoint = CGPoint(x: 1, y: 0)
            layer.locations = [0, 1]

        case .ViewGradientStyleTopLeft:
            layer.startPoint = CGPoint(x: 0, y: 1)
            layer.endPoint = CGPoint(x: 1, y: 0)
            layer.locations = [0, 1]
            
        case .ViewGradientStyleTop:
            layer.startPoint = CGPoint(x: 0, y: 0)
            layer.endPoint = CGPoint(x: 0, y: 1.0)
            layer.locations = [0, 1]
            
        case .ViewGradientStyleBottomLeft:
            layer.startPoint = CGPoint(x: 1, y: 0)
            layer.endPoint = CGPoint(x: 0, y: 1)
            layer.locations = [0, 1]
            
        }


        //将自定义的layer添加在btn的layer上
        self.layer.insertSublayer(layer, at: 0)

        // self如果是UILabel，masksToBounds设为true会导致文字消失
        self.layer.masksToBounds = false
    }
    
    // MARK: 移除渐变图层
    // （当希望只使用backgroundColor的颜色时，需要先移除之前加过的渐变图层）
    func removeGradientLayer() {
       if let sl = self.layer.sublayers {
           for layer in sl {
               if layer.isKind(of: CAGradientLayer.self) {
                   layer.removeFromSuperlayer()
               }
           }
       }
   }
    

    // MARK:view边框
    func borderColor(color:UIColor){
        self.layer.borderColor = color.cgColor
    }
    
    // MARK: view边框
    func borderWidth(width:CGFloat){
        self.layer.borderWidth = width
    }
    
    // MARK: view圆角
    func cornerRadius(cornerRadius:CGFloat) {
        self.layer.cornerRadius = cornerRadius;
        self.layer.masksToBounds = true;
    }
    
    
    // MARK: 裁剪 view 的圆角
    func clipRectCorner(direction: UIRectCorner, cornerRadius: CGFloat) {
        self.layoutIfNeeded()
        let cornerSize = CGSize(width: cornerRadius, height: cornerRadius)
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: direction, cornerRadii: cornerSize)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.addSublayer(maskLayer)
        layer.mask = maskLayer
    }

    /// x
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }

    /// y
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }

    /// height
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame                 = tempFrame
        }
    }

    /// width
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }

    /// size
    var size: CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }

    /// centerX
    var centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }

    /// centerY
    var centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter;
        }
    }
    
}



