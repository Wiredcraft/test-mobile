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
    var animateLine: CALayer?
    
    var session: AVCaptureSession?
    var videoLayer: AVCaptureVideoPreviewLayer?
    
    var didScannedQRCode: ((String) -> Void)?
    
    let squareSpace: CGFloat = 50.0
    var squareWidth: CGFloat {
        return kScreenWidth - squareSpace * 2
    }
    var squareTop: CGFloat {
        return kNavBarHeight + (kScreenHeight - kNavBarHeight - squareWidth) / 2.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadCaptureConfig()
        self.loadSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadSubViews() {
        self.videoLayer = AVCaptureVideoPreviewLayer.init(session: self.session!)
        self.videoLayer?.videoGravity = .resizeAspectFill
        self.layer.addSublayer(self.videoLayer!)
        
        self.maskLayer = CAShapeLayer()
        self.maskLayer?.fillRule = .evenOdd
        self.maskLayer?.fillColor = UIColor.black.withAlphaComponent(0.5).cgColor
        self.layer.addSublayer(self.maskLayer!)
        
        self.animateLine = CALayer.init()
        self.animateLine?.backgroundColor = themeColor.cgColor
        self.layer.addSublayer(self.animateLine!)
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
        
        let notificationCenter = NotificationCenter.default
        let queue = OperationQueue.main
        let notificationName = NSNotification.Name.AVCaptureInputPortFormatDescriptionDidChange
        notificationCenter.addObserver(forName:notificationName,
                                       object: nil,
                                       queue: queue,
                                       using: {(a) in
                                        metadataOutput.rectOfInterest = (self.videoLayer?.metadataOutputRectConverted(fromLayerRect: self.scanArea()))!
        })
    }
    
    func scanArea() -> CGRect {
        return CGRect.init(x: self.squareSpace, y: self.squareTop, width: squareWidth, height: squareWidth);
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        let metadataObj = metadataObjects.first as! AVMetadataMachineReadableCodeObject
        if metadataObj.type == AVMetadataObject.ObjectType.qr {//for qr code
            let qrCodeString = metadataObj.stringValue
            if let resultBlock = self.didScannedQRCode {
                resultBlock(qrCodeString!)
            }
        }

        self.stopScan()
    }
    
    public func startScan() {
        self.session?.startRunning()
        let animation: CABasicAnimation = CABasicAnimation.init(keyPath: "position.y")
        animation.repeatCount = Float(CGFloat.greatestFiniteMagnitude)
        animation.duration = 2;
        animation.isRemovedOnCompletion = false;
        animation.fromValue = squareTop;
        animation.toValue = squareTop + squareWidth;
        self.animateLine?.add(animation, forKey: "animateLine")
    }
    
    public func stopScan() {
        self.session?.stopRunning()
        self.animateLine?.removeAnimation(forKey: "animateLine")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.maskLayer?.frame = self.bounds
        self.videoLayer?.frame = self.bounds
        self.animateLine?.frame = CGRect.init(x: squareSpace, y: squareTop, width: squareWidth, height: 2)
        self.layoutMask()
    }
    
    func layoutMask() {
        let path = UIBezierPath.init(rect: (self.maskLayer?.bounds)!).cgPath
        let squarePath = UIBezierPath.init(rect: CGRect.init(x: squareSpace, y: squareTop, width: squareWidth, height: squareWidth)).cgPath
        let thePath = CGMutablePath.init()
        thePath.addPath(path)
        thePath.addPath(squarePath)
        self.maskLayer?.path = thePath
    }

}

