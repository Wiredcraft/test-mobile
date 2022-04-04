//
//  HeaderView.swift
//  MobileTest
//
//  Created by yanjun lee on 2022/3/29.
//

import UIKit
import SnapKit

class HeaderView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    override func draw(_ rect: CGRect) {
        let color = UIColor.black
        color.set()
        let path  = UIBezierPath(arcCenter: CGPoint(x: UIScreen.main.bounds.width/2, y: -230),
                                 radius: 460, startAngle: 0, endAngle: .pi, clockwise: true)
        path.addLine(to: CGPoint(x: UIScreen.main.bounds.width/2, y: 0))
        path.lineWidth = 1.0
        
        path.close()
        path.fill()

    }
}
