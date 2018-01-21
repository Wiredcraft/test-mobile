//
//  ViewController.swift
//  QRGenerator
//
//  Created by buginux on 2018/1/18.
//  Copyright © 2018年 buginux. All rights reserved.
//

import UIKit
import QRCodeReader
import MBProgressHUD

class ViewController: UIViewController {
    
    lazy var readerViewController: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "QRGenerator"
    }
    
    @IBAction func actionScan() {
        readerViewController.delegate = self
        present(readerViewController, animated: true, completion: nil)
    }
    
    private func showToast(withText text: String) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text
        hud.label.text = text
        
        hud.hide(animated: true, afterDelay: 3.0)
    }
}

extension ViewController: QRCodeReaderViewControllerDelegate {
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        
        dismiss(animated: true) {
            self.showToast(withText: "Scan result: \(result.value)")
        }
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }
}

