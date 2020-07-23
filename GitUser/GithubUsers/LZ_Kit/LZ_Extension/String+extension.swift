//
//  String+extension.swift
//  SMHCommerce
//
//  Created by lvzhao on 2020/6/3.
//  Copyright © 2020 lvzhao. All rights reserved.
//

import Foundation
import UIKit

extension String {
        
    //MARK:计算字符串的宽
    func lz_widthWithString(font: UIFont, height: CGFloat) -> CGFloat {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }

    
    //MARK:计算字符串的h高
    func lz_heightWithString(font: UIFont, width: CGFloat) -> CGFloat {
       let rect = NSString(string: self).boundingRect(with: CGSize(width:width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
       return ceil(rect.height)
    }
}

