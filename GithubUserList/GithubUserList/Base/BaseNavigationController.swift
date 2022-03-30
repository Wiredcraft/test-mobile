//
//  BaseNavigationController.swift
//  GithubUserList
//
//  Created by zhaotianyang on 2022/3/26.
//

import UIKit

class BaseNavigationController: UINavigationController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
        view.backgroundColor = UIColor.white
    }
    
}
