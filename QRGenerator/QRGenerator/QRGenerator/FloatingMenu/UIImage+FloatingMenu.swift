//
//  UIImage+FloatingMenu.swift
//  QRGenerator
//
//  Created by 杨志超 on 2018/1/21.
//  Copyright © 2018年 buginux. All rights reserved.
//

import UIKit

extension UIImage {
    
    private struct Constants {
        static let plusLineWidth: CGFloat = 2.0
        static let plusButtonScale: CGFloat = 0.6
    }
    
    class func plusImage(withSize size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        let halfWidth = size.width / 2.0
        let halfHeight = size.height / 2.0
        
        // set up the width and height variables
        // for the horizontal stroke
        let plusWidth: CGFloat = min(size.width, size.height) * Constants.plusButtonScale
        let halfPlusWidth = plusWidth / 2.0
        
        // create the path
        let plusPath = UIBezierPath()
        
        // set the path's line width to the height of the stroke
        plusPath.lineWidth = Constants.plusLineWidth
        
        // move the initial point of the path
        // to the start of horizontal stroke
        plusPath.move(to: CGPoint(x: halfWidth - halfPlusWidth, y: halfHeight))
        
        // add a point to the path at the end of the stroke
        plusPath.addLine(to: CGPoint(x: halfWidth + halfPlusWidth, y: halfHeight))
        
        // vertical line
        plusPath.move(to: CGPoint(x: halfWidth, y: halfHeight - halfPlusWidth))
        
        plusPath.addLine(to: CGPoint(x: halfWidth, y: halfHeight + halfPlusWidth))
        
        // set the storke color
        UIColor.white.setStroke()
        
        // draw the storke
        plusPath.stroke()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    class func closeImage(withSize size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        let halfWidth = size.width / 2.0
        let halfHeight = size.height / 2.0
        
        // set up the width and height variables
        // for the horizontal stroke
        let plusWidth: CGFloat = min(size.width, size.height) * Constants.plusButtonScale
        let halfPlusWidth = plusWidth / 2.0
        
        // create the path
        let plusPath = UIBezierPath()
        
        // set the path's line width to the height of the stroke
        plusPath.lineWidth = Constants.plusLineWidth
        
        let cosinus = CGFloat(cos(45.0 * Double.pi / 180.0))
        
        // move the initial point of the path
        // to the start of horizontal stroke
        plusPath.move(to: CGPoint(x: halfWidth - halfPlusWidth * cosinus, y: halfHeight - halfPlusWidth * cosinus))
        
        // add a point to the path at the end of the stroke
        plusPath.addLine(to: CGPoint(x: halfWidth + halfPlusWidth * cosinus, y: halfHeight + halfPlusWidth * cosinus))
        
        // vertical line
        plusPath.move(to: CGPoint(x: halfWidth - halfPlusWidth * cosinus, y: halfHeight + halfPlusWidth * cosinus))
        
        plusPath.addLine(to: CGPoint(x: halfWidth + halfPlusWidth * cosinus, y: halfHeight - halfPlusWidth * cosinus))
        
        // set the storke color
        UIColor.white.setStroke()
        
        // draw the storke
        plusPath.stroke()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
