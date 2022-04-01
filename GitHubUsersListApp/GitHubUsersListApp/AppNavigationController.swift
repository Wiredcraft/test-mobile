//
//  AppNavigationController.swift
//  GitHubUsersListApp
//
//  Created by Joy Cheng on 2022/4/1.
//

import UIKit

class AppNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
    }
    
    override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
}

