//
//  StyledNavigationController.swift
//  test_mobile
//
//  Created by Jun Ma on 2022/3/20.
//

import UIKit

class StyledNavigationController: UINavigationController {
    override var childForStatusBarStyle: UIViewController? {
        topViewController?.childForStatusBarStyle ?? topViewController
    }
}
