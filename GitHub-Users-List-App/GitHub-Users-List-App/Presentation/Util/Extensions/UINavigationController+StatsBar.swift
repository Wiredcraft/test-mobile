//
//  UINavigationController+StatsBar.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/11.
//

import Foundation
import UIKit
extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }

    open override var childForStatusBarStyle: UIViewController? {
        return visibleViewController
    }
}
