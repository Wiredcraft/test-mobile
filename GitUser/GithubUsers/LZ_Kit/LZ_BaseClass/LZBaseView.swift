//
//  LZBaseView.swift
//  SMHCommerce
//
//  Created by lvzhao on 2020/1/9.
//  Copyright © 2020 lvzhao. All rights reserved.
//

import UIKit

class LZBaseView: UIView {
    
    
    init(viewModel: LZBaseViewModel) {
        super.init(frame:.zero)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
