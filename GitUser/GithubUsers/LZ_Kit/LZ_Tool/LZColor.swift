//
//  LZColor.swift
//  SMHCommerce
//
//  Created by lvzhao on 2020/1/9.
//  Copyright © 2020 lvzhao. All rights reserved.
//

import UIKit


//生成颜色
func RGBA(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> (UIColor){
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

//十六进制颜色值
func UIColorFromHex(rgbValue:Int) -> (UIColor) {
    return UIColor.init(_colorLiteralRed:((Float)((rgbValue & 0xFF0000) >> 16))/255.0,
                                    green: ((Float)((rgbValue & 0xFF00) >> 8))/255.0,
                                    blue: ((Float)(rgbValue & 0xFF))/255.0 ,
                                    alpha: 1.0)
    
}


//rbg转UIColor(16进制)带透明度
func UIColorFromHexA(rgbaValue:Int) -> UIColor {
    return UIColor.init(_colorLiteralRed:((Float)((rgbaValue & 0xFF0000) >> 16))/255.0,
                                    green: ((Float)((rgbaValue & 0xFF00) >> 8))/255.0,
                                    blue: ((Float)(rgbaValue & 0xFF))/255.0 ,
                                    alpha: ((Float)((rgbaValue & 0xFF000000) >> 24))/255.0)
}


//随机颜色
func UIColorRandom () ->(UIColor){
    let red = CGFloat(arc4random()%255)
    let green = CGFloat(arc4random()%255)
    let blue = CGFloat(arc4random()%255)
    return RGBA(r: red, g: green, b: blue, a:1)

}

let ColorTint = UIColorFromHex(rgbValue: 0xFF661B)
let ColorBackGround = UIColorFromHex(rgbValue: 0xF2F2F2)
let ColorText = UIColorFromHex(rgbValue: 0x363636)
let ColorPlacrholder = UIColorFromHex(rgbValue: 0xA8A8A8)
let ColorLine = UIColorFromHex(rgbValue: 0xE5E5E5)



