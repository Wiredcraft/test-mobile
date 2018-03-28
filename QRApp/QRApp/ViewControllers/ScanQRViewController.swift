//
//  ScanQRViewController.swift
//  QRApp
//
//  Created by Ville Välimaa on 18/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import UIKit
import AVFoundation
import UIKit

/// ViewController to handle scanning QR images with
/// QRCaptureSession.
///
class ScanQRViewController: QRBaseViewController, QRCaptureSessionDelegate {
    
    private var qrSession: QRCaptureSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        
        guard let session = QRCaptureSession(targetView: view) else {
            Alert.showOKAlert("Scanning not supported", message: "QR Scanning failure", showIn: self)
            return
        }
        qrSession = session
        session.delegate = self
        session.start()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let session = qrSession else { return }
        
        if !session.isRunning {
            session.start()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let session = qrSession else { return }
        
        if session.isRunning {
            session.stop()
        }
    }
    
    func didReadQRCode(code: String) {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        Alert.showOKAlert("QR Code found!", message: "'\(code)'", showIn: self)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
