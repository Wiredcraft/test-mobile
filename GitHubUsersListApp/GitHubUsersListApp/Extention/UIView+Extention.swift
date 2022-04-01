//
// UIView+Extention.swift
//  CJWProject
//
//  Created by Joy Cheng on 2022/3/31.
//

import UIKit

extension UIView {
     public func filletedCorner(_ cornerRadii:CGSize,_ roundingCorners:UIRectCorner)  {
          let fieldPath = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: roundingCorners, cornerRadii:cornerRadii )
          let fieldLayer = CAShapeLayer()
          fieldLayer.frame = bounds
          fieldLayer.path = fieldPath.cgPath
          self.layer.mask = fieldLayer
    }
}
