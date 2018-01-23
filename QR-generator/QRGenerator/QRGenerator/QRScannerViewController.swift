//
//  QRScannerViewController.swift
//  QRGenerator
//
//  Created by tripleCC on 2018/1/23.
//  Copyright © 2018年 tripleCC. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation

public protocol QRScannerViewControllerDelegate {
    func scannerViewController(_: UIViewController, didFinishScanWithResult result: String?)
}

class QRScannerViewController: UIViewController {
    public var delegate: QRScannerViewControllerDelegate?
    private lazy var session: AVCaptureSession = {
        let session = AVCaptureSession()
        session.canSetSessionPreset(AVCaptureSession.Preset.high)
        return session
    }()
    private lazy var maskView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.alpha = 0.5
        return view
    }()
    private let scanWindowSize = CGSize(width: 200, height: 200)
    private let screenSize = UIScreen.main.bounds.size
    private lazy var scanWindowFrame: CGRect = {
        return CGRect(x: 0.5 * (screenSize.width - scanWindowSize.width), y: 0.4 * (screenSize.height - scanWindowSize.height), width: scanWindowSize.width, height: scanWindowSize.height)
    }()
    
    private lazy var scanMaskLayer: CALayer = {
        let path = UIBezierPath(rect: UIScreen.main.bounds)
        path.append(UIBezierPath(rect: scanWindowFrame))
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.strokeColor = UIColor.orange.cgColor
        return layer
    }()
    
    
    override func viewDidLoad() {
        setupNavigation()
        layoutPageSubviews()
        sessionAttachPreviewLayer()
        sessionAddInput()
        sessionAddOutput()
        sessionStartScan()
    }
    
    private func setupNavigation() {
        navigationItem.title = "QRScaner"
    }
    
    private func sessionStartScan() {
        if session.inputs.count > 0 {
            session.startRunning()
        }
    }
    
    private func sessionAddOutput() {
        let viewSize = view.frame.size
        let output = AVCaptureMetadataOutput()
        output.rectOfInterest = CGRect(x: scanWindowFrame.origin.y / viewSize.height, y: scanWindowFrame.origin.x / viewSize.width, width: scanWindowSize.height / viewSize.height, height: scanWindowSize.width / viewSize.width)
        session.addOutput(output)
        
        if output.availableMetadataObjectTypes.count != 0 {
            output.metadataObjectTypes = [.qr, .ean13, .ean8, .code128]
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        }
    }
    
    private func sessionAddInput() {
        if let device = AVCaptureDevice.default(for: .video),
            let input = try? AVCaptureDeviceInput(device: device) {
            session.addInput(input)
        }
    }
    
    private func sessionAttachPreviewLayer() {
        let layer = AVCaptureVideoPreviewLayer(session: session)
        layer.videoGravity = .resizeAspectFill
        layer.frame = view.frame
        view.layer.insertSublayer(layer, at: 0)
    }
    
    private func layoutPageSubviews() {
        view.addSubview(maskView)
        maskView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        maskView.layer.mask = scanMaskLayer
    }
}

extension QRScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard metadataObjects.count > 0 else { return }
        
        session.stopRunning()
        delegate?.scannerViewController(self, didFinishScanWithResult: (metadataObjects.first as? AVMetadataMachineReadableCodeObject)?.stringValue)
    }
}
