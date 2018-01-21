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
    
    @IBAction func handleMenuButton(sender: FloatingButton) {
        let controller = FloatingMenuViewController(fromView: sender)
        controller.delegate = self
        
        controller.buttonItems = [
            FloatingButton(image: UIImage(named: "qr-code")),
            FloatingButton(image: UIImage(named: "qr-code-scan"))
        ]
        
        present(controller, animated: true, completion: nil)
    }
    
    private func actionScan() {
        readerViewController.delegate = self
        present(readerViewController, animated: true, completion: nil)
    }
    
    private func actionGenerateQRCode() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "QRCodeGenerateViewController")
        navigationController?.pushViewController(controller, animated: true)
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

extension ViewController: FloatingMenuViewControllerDelegate {
    func floatingMenuController(controller: FloatingMenuViewController, didTapButton button: UIButton, atIndex index: Int) {
        controller.dismiss(animated: true, completion: nil)
        
        if index == 0 {
            actionScan()
        } else if index == 1 {
            actionGenerateQRCode()
        }
    }
}

