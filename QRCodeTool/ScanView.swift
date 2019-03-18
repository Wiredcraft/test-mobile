//
//  ScanView.swift
//  QRCodeTool
//
//  Created by 彭柯柱 on 2019/3/17.
//  Copyright © 2019 彭柯柱. All rights reserved.
//

import UIKit
import AVKit

class ScanView: UIView, AVCaptureMetadataOutputObjectsDelegate {
    
    var maskLayer: CAShapeLayer?
    var session: AVCaptureSession?
    var videoLayer: AVCaptureVideoPreviewLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.loadCaptureConfig()
        self.loadSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadSubViews() {
        
        self.maskLayer = CAShapeLayer()
        self.maskLayer?.fillRule = .evenOdd
        self.maskLayer?.backgroundColor = UIColor.black.withAlphaComponent(0.1).cgColor
        self.layer.addSublayer(self.maskLayer!)
        
        self.videoLayer = AVCaptureVideoPreviewLayer.init(session: self.session!)
        self.layer.addSublayer(self.videoLayer!)
    }
    
    func loadCaptureConfig() {
        self.session = AVCaptureSession()
        
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        guard let deviceInput = try? AVCaptureDeviceInput(device: device) else { return }
        let metadataOutput = AVCaptureMetadataOutput()
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        if session!.canAddInput(deviceInput) {
            session?.addInput(deviceInput)
        }
        if session!.canAddOutput(metadataOutput) {
            session?.addOutput(metadataOutput)
        }
        metadataOutput.metadataObjectTypes = [.qr]
//        metadataOutput.rectOfInterest = CGRect.init(x: (self.scanLayer?.frame.minX)! / kScreenWidth, y: (self.scanLayer?.frame.minY)! / kScreenHeight, width: (self.scanLayer?.frame.size.width)! / kScreenWidth, height: (self.scanLayer?.frame.size.height)! / kScreenHeight)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.maskLayer?.frame = self.bounds
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
    }
    
}

