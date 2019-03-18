//
//  ScanViewController.swift
//  QRCodeTool
//
//  Created by 彭柯柱 on 2019/3/17.
//  Copyright © 2019 彭柯柱. All rights reserved.
//

import UIKit

class ScanViewController: BaseViewController {
    
    let scanView = ScanView.init()
    
    override func loadView() {
        self.view = scanView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Scan"
    }

}
