//
//  QRCodeViewController.swift
//  QR
//
//  Created by Samuel Zhang on 7/24/16.
//  Copyright © 2016 Samuel Zhang. All rights reserved.
//

import UIKit
import CoreImage

func createQRFromString(str: NSString) -> UIImage? {
    let stringData = str.dataUsingEncoding(NSUTF8StringEncoding)
    let filter = CIFilter(name: "CIQRCodeGenerator")
    filter?.setValue(stringData, forKey: "inputMessage")
    filter?.setValue("H", forKey: "inputCorrectionLevel")

    let image = filter?.outputImage?.imageByApplyingTransform(CGAffineTransformMakeScale(5.0, 5.0))
    if let image = image {
        return UIImage(CIImage:image, scale:1.0, orientation:UIImageOrientation.Down)
    } else {
        return nil
    }
}

class QRCodeViewController: UIViewController {

    @IBOutlet weak var timeoutLabel: UILabel!
    @IBOutlet weak var qrImageView: UIImageView!
    
    let seedManager = SeedManager()
    var theModel: SeedModel?
    var timer: NSTimer?

    func loadUI() {
        timeoutLabel.text = "loading QR"
        seedManager.getSeedAsync { (model) -> Void in
            self.theModel = model
            guard let model = model else {
                self.timeoutLabel.text = "failed to load data"
                self.qrImageView.image = nil;
                return
            }
            if let img = createQRFromString(model.seed) {
                self.qrImageView.image = img
            }
            self.startSeedTimeout()
        }
    }
    
    func stopSeedTimeout() {
        if let timer = timer {
            timer.invalidate()
        }
        timer = nil
    }
    func startSeedTimeout() {
        guard let model = theModel else { return }
        
        if timer == nil {
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:#selector(QRCodeViewController.startSeedTimeout), userInfo: nil, repeats:true)
        }
        
        let timeout = Int(model.expireTimeout())
        self.timeoutLabel.text = "\(timeout)s"
        print("tick \(timeout)")
        
        if timeout <= 0 {
            self.stopSeedTimeout()
            self.loadUI()
        }
    }
    
    func startListenScreenEvents() {
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector:#selector(QRCodeViewController.startSeedTimeout), name:UIApplicationDidBecomeActiveNotification, object: nil)
        nc.addObserver(self, selector:#selector(QRCodeViewController.stopSeedTimeout), name:UIApplicationWillResignActiveNotification, object: nil)
    }
    func stopListenScreenEvents() {
        let nc = NSNotificationCenter.defaultCenter()
        nc.removeObserver(self)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        stopSeedTimeout()
        stopListenScreenEvents()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.loadUI()
        startListenScreenEvents()
    }

}
