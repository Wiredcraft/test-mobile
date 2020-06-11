//
//  WCNavigationController.swift
//  Wiredcraft
//
//  Created by codeLocker on 2020/6/10.
//  Copyright © 2020 codeLocker. All rights reserved.
//

import UIKit

class WCNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadUI()
    }

    //MARK: - Load_UI
    private func loadUI() {
        /// set default background color
        self.view.backgroundColor = UIColor.white
    }
}
