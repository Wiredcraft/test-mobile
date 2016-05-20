//
//  QRScannerViewController.swift
//  QRApp
//
//  Created by 顾强 on 16/5/18.
//  Copyright © 2016年 johnny. All rights reserved.
//

import UIKit
import AVFoundation

class QRScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var scannerView: UIView!
    @IBOutlet weak var infomationLabel: UILabel!
    
    var greenView:UIView?
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var input: AVCaptureInput?
        let output = AVCaptureMetadataOutput()
        do{
            input = try AVCaptureDeviceInput.init(device: captureDevice)
        }catch{
            print(error)
        }
        
        captureSession = AVCaptureSession()
        captureSession?.addInput(input)
        captureSession?.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = scannerView.bounds
        scannerView.layer.addSublayer(videoPreviewLayer!)
        
        captureSession?.startRunning()
        
        greenView = UIView()
        greenView?.layer.borderColor = UIColor.greenColor().CGColor
        greenView?.layer.borderWidth = 2
        scannerView.addSubview(greenView!)
        scannerView.bringSubviewToFront(greenView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        if metadataObjects.count == 0 {
            greenView?.frame = CGRectZero
            return
        }
        
        let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObject.type == AVMetadataObjectTypeQRCode {
            let qrcodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObject)
            greenView?.frame = (qrcodeObject?.bounds)!
            print(greenView?.frame)
            if metadataObject.stringValue != nil {
                infomationLabel.text = metadataObject.stringValue
                print(metadataObject.stringValue)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
