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

    @IBOutlet weak var qrView: UIImageView!
    @IBOutlet weak var countdownLb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        PKHUD.sharedHUD.contentView = PKHUDProgressView.init(title: "QRApp", subtitle: "loading...")
        PKHUD.sharedHUD.show()
        Alamofire.request(.GET, "http://localhost:3000/seed").responseJSON { (response) in
            print(response)
            print(response.result)   // result of response serialization
            
            let resultJson: NSDictionary = response.result.value as! NSDictionary
            let dataString: String = resultJson["data"]!["data"] as! String
            let endingDate = resultJson["data"]!["expiredDate"]
            print(endingDate)
            
            self.qrView.image = QRCode(dataString)?.image
            
            PKHUD.sharedHUD.hide(animated: true, completion: nil)
            
            self.countdownLb.startCountingWithTimeInterval(60)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
