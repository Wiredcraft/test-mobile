//
//  QRCaptureSession.swift
//  QRApp
//
//  Created by Ville Välimaa on 18/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import AVFoundation
import UIKit

/// Protocol to provide call in case of successful
/// QR code capture.
///
@objc protocol QRCaptureSessionDelegate {
    func didReadQRCode(code: String)
}

/// Wrapper for capturing QR codes with
/// AVFoundations tools.
///
class QRCaptureSession: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    
    private var captureSession = AVCaptureSession()
    private var previewLayer = AVCaptureVideoPreviewLayer()
    private var metadataOutput = AVCaptureMetadataOutput()
    
    var isRunning: Bool {
        return captureSession.isRunning
    }
    
    weak var delegate: QRCaptureSessionDelegate? {
        didSet {
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        }
    }
    
    init?(targetView: UIView) {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return nil
        }
        
        // Verify capture session can add input.
        //
        guard captureSession.canAddInput(videoInput) else {
            return nil
        }
        captureSession.addInput(videoInput)
        
        // Verify capture session can add output.
        //
        guard captureSession.canAddOutput(metadataOutput) else {
            return nil
        }
        captureSession.addOutput(metadataOutput)
        
        metadataOutput.metadataObjectTypes = [.qr]
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = targetView.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        targetView.layer.addSublayer(previewLayer)
    }
    
    func start() {
        captureSession.startRunning()
    }
    
    func stop() {
        captureSession.stopRunning()
    }
    
    
    /// Forward local AVCaptureMetadataOutputObjectsDelegate method to
    /// QRCaptureSessionDelegate.
    ///
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard
            let metadataObject = metadataObjects.first,
            let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
            let qrCodeAsString = readableObject.stringValue else { return }
        delegate?.didReadQRCode(code: qrCodeAsString)
    }
}
