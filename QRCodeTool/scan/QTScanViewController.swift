//
//  QTScanViewController.swift
//  QRCodeTool
//
//  Created by 彭柯柱 on 2019/3/17.
//  Copyright © 2019 彭柯柱. All rights reserved.
//

import UIKit

class QTScanViewController: QTViewController {
    
    let scanView = QTScanView.init()
    
    override func loadView() {
        self.view = scanView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Scan"
        self.scanView.didScannedQRCode = {(scanResult) in
            let scanResViewController = QTScanResultViewController()
            scanResViewController.qrCode = scanResult
            self.navigationController?.pushViewController(scanResViewController, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.scanView.startScan()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.scanView.stopScan()
    }
}
