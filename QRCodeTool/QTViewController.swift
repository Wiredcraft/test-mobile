//
//  QTViewController.swift
//  QRCodeTool
//
//  Created by 彭柯柱 on 2019/3/17.
//  Copyright © 2019 彭柯柱. All rights reserved.
//

import UIKit

class QTViewController: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        if (self.navigationController?.viewControllers.count)! > 1 {
            let backImage = UIImage.init(named: "mobi_native_icon_back")?.withRenderingMode(.alwaysOriginal)
            self.navigationItem.leftBarButtonItem = .init(image: backImage, style: .plain, target: self, action: #selector(backButtonClicked))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer {
            return self.navigationController!.viewControllers.count > 1
        }
        return true
    }
    
    @objc func backButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }

}
