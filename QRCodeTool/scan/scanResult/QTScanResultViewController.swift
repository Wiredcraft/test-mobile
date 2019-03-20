//
//  QTScanResultViewController.swift
//  QRCodeTool
//
//  Created by 彭柯柱 on 2019/3/19.
//  Copyright © 2019 彭柯柱. All rights reserved.
//

import UIKit

class QTScanResultViewController: QTViewController {

    public var qrCode: String?
    let scanResultView: QTScanResultView = QTScanResultView()
    
    override func loadView() {
        scanResultView.qrCode = self.qrCode
        self.view = scanResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Scanned Result"
        // Do any additional setup after loading the view.
    }

}
