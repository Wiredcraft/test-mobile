//
//  BaseViewController.swift
//  QRCodeTool
//
//  Created by 彭柯柱 on 2019/3/17.
//  Copyright © 2019 彭柯柱. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        if (self.navigationController?.viewControllers.count)! > 1 {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "mobi_native_icon_back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backButtonClicked))
        }
    }
    
    @objc func backButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }

}
