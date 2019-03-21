//
//  QTHomeViewController.swift
//  QRCodeTool
//
//  Created by 彭柯柱 on 2019/3/16.
//  Copyright © 2019 彭柯柱. All rights reserved.
//

import UIKit
import SnapKit

class QTHomeViewController: QTViewController {
    let homeView = QTHomeView()
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        
        self.homeView.scanButton?.addTarget(self, action: #selector(scanButtonClicked), for: .touchUpInside)
        self.homeView.generateButton?.addTarget(self, action: #selector(generateButtonClicked), for: .touchUpInside)
    }
    
    @objc func scanButtonClicked() {
        let scanViewController = QTScanViewController.init()
        self.navigationController?.pushViewController(scanViewController, animated: true)
    }
    
    @objc func generateButtonClicked() {
        let generateViewController = QTGenerateViewController.init()
        self.navigationController?.pushViewController(generateViewController, animated: true)
    }
}
