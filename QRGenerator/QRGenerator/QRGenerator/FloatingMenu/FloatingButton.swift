//
//  FloatingButton.swift
//  QRGenerator
//
//  Created by 杨志超 on 2018/1/21.
//  Copyright © 2018年 buginux. All rights reserved.
//

import UIKit

class FloatingButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    convenience init(image: UIImage?, backgroundColor: UIColor = UIColor.flatWhiteColor) {
        self.init()
        setImage(image, for:.normal)
        setBackgroundImage(backgroundColor.image, for: .normal)
    }
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 50.0, height: 50.0))
    }
    
    private func commonInit() {
        tintColor = UIColor.white
        
        setImage(UIImage.plusImage(withSize: bounds.size), for: .normal)
        setBackgroundImage(UIColor.flatBlueColor.image, for: .normal)
        
        layer.cornerRadius = bounds.width / 2.0
        layer.masksToBounds = true
    }
    
    
    
}
