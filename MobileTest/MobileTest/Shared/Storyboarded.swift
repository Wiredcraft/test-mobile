//
//  Storyboarded.swift
//  MobileTest
//
// Created by yanjun lee on 2022/3/26
//

import UIKit

protocol Storyboardable {
    static func instantiate(from storyboard: String) -> Self
}

extension Storyboardable where Self: UIViewController {
    static func instantiate(from storyboard: String) -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: storyboard, bundle: Bundle.main)
        
        return storyboard.instantiateViewController(identifier: className)
    }
}
