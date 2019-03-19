//
//  GenerateViewController.swift
//  QRCodeTool
//
//  Created by 彭柯柱 on 2019/3/17.
//  Copyright © 2019 彭柯柱. All rights reserved.
//

import UIKit

class GenerateViewController: BaseViewController {

    override func loadView() {
        self.view = GenerateView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "QR-Code"
    }

}
