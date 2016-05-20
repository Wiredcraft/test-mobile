//
//  QRGeneratorViewController.swift
//  QRApp
//
//  Created by 顾强 on 16/5/19.
//  Copyright © 2016年 johnny. All rights reserved.
//

import UIKit
import Alamofire
import QRCode
import PKHUD

class QRGeneratorViewController: UIViewController {
        /// generated qr view
    @IBOutlet weak var qrView: UIImageView!
        /// count down label
    @IBOutlet weak var countdownLb: UILabel!
    
    private var SeedAPI = "http://10.0.2.9:3000/seed"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if let qrSaver = QRLocalSaver.readFromLocal() {
            if qrSaver.ExpiredDate.timeIntervalSinceNow > 0 {
                return self.renderQRStratCounting(qrSaver.dataString, expiredDate: qrSaver.ExpiredDate)
            }
        }
        
        self.requestForQRData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.countdownLb.cancelCounting()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func requestForQRData() -> Void {
        // show waiting HUD
        PKHUD.sharedHUD.contentView = PKHUDProgressView.init(title: "QRApp", subtitle: "loading...")
        PKHUD.sharedHUD.show()
        
        // start the request
        Alamofire.request(.GET, SeedAPI).responseJSON { (response) in
            // get data string
            
            var resultJson: NSDictionary?
            var dataString: String?
            if let resultValue = response.result.value {
                resultJson = resultValue as? NSDictionary
            }else{
                return self.handleBadResponse(nil)
            }
            
            if let dataInJson = resultJson!["data"]!["data"] {
                dataString = dataInJson as? String
            }else{
                return self.handleBadResponse(nil)
            }
            
            // get expired date
            var endingDateString: NSString = resultJson!["data"]!["expiredDate"] as! String
            endingDateString = endingDateString.substringToIndex(19)
            let dateFormate = NSDateFormatter()
            dateFormate.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            dateFormate.timeZone = NSTimeZone(forSecondsFromGMT: 0)
            let expiredDate = dateFormate.dateFromString(endingDateString as String)
            // if the request is too early that server has not refreshed
            if expiredDate!.timeIntervalSinceNow < 1 {
                return self.requestForQRData()
            }
            
            //save data to local
            QRLocalSaver.saveToLocal(dataString!, date: expiredDate!)
            // render and count
            self.renderQRStratCounting(dataString, expiredDate: expiredDate)
            // hide HUD
            PKHUD.sharedHUD.hide(animated: true, completion: nil)
        }
    }
    
    func handleBadResponse(hint:String?) -> Void {
        if PKHUD.sharedHUD.isVisible {
            PKHUD.sharedHUD.hide(animated: false, completion: nil)
        }
        let msg = (hint != nil) ? hint : "bad response"
        PKHUD.sharedHUD.contentView = PKHUDTextView.init(text: msg)
        PKHUD.sharedHUD.show()
        PKHUD.sharedHUD.hide(afterDelay: 2, completion: nil)
    }
    
    func renderQRStratCounting(dataString:String!, expiredDate:NSDate!) -> Void {
        // generate qr-code the show it
        self.qrView.image = QRCode(dataString)?.image
        // label start count down
        self.countdownLb.startCountingWithEndingDate(expiredDate, countClosure: { (remainTime) in
            if remainTime < 1 {
                self.requestForQRData()
            }
        })
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
