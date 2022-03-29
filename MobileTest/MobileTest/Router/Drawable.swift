//
//  Drawable.swift
//  MobileTest
//
//  Created by yanjun lee on 2022/3/26.
//

import UIKit

protocol Drawable {
    
    var viewController: UIViewController? { get }
}

extension UIViewController: Drawable {
    
    var viewController: UIViewController? {
        return self
    }
}
