//
//  LZCache.swift
//  SMHCommerce
//
//  Created by lvzhao on 2020/6/3.
//  Copyright © 2020 lvzhao. All rights reserved.
//

import Foundation


func objectForKey(defaultName:String) -> Any {
    let anyObjet :Any = UserDefaults.standard.object(forKey: defaultName) as Any
    return anyObjet
}


func setBool(value:Bool ,forKey:String){
    UserDefaults.standard.set(value, forKey: forKey)
    UserDefaults.standard.synchronize()
}


func setValue(value:Any, forKey:String){
    UserDefaults.standard.set(value, forKey: forKey)
    UserDefaults.standard.synchronize()
}


//  Converted to Swift 5.2 by Swiftify v5.2.28138 - https://swiftify.com/
//UserDefaults.standard.set(value, forKey: defaultName)
//UserDefaults.standard.synchronize()
