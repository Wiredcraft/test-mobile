//
//  ScanViewController.swift
//  QRCodeTool
//
//  Created by 彭柯柱 on 2019/3/17.
//  Copyright © 2019 彭柯柱. All rights reserved.
//

import UIKit

class ScanViewController: BaseViewController {
    
    let scanView = ScanView.init()
    
    override func loadView() {
        self.view = scanView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Scan"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
