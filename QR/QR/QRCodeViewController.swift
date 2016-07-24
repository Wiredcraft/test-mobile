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
    
    func loadUI() {
        print("getSeedAsync")
        seedManager.getSeedAsync { (model) -> Void in
            print("getSeedAsync callback")
            guard let model = model else {
                self.timeoutLabel.text = "failed to load data"
                return
            }
            self.theModel = model
            if let img = createQRFromString(model.seed) {
                self.qrImageView.image = img
            }
            self.startSeedTimeout()
        }
    }
    
    func startSeedTimeout() {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadUI()
    }

}
