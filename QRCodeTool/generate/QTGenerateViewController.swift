//
//  QTGenerateViewController.swift
//  QRCodeTool
//
//  Created by 彭柯柱 on 2019/3/17.
//  Copyright © 2019 彭柯柱. All rights reserved.
//

import UIKit

class QTGenerateViewController: QTViewController {
    
    let apiGetSeed: QTApiGetSeed = QTApiGetSeed()
    let generateView: QTGenerateView = QTGenerateView()
    
    override func loadView() {
        self.view = generateView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "QR-Code"
        
        self.loadData(true)
        
        self.generateView.shouldUpdateSeed = {[weak self] in
            self?.loadData(false)
        }
    }
    
    func loadData(_ showLoading: Bool) {
        self.generateView.isLoading = true
        self.apiGetSeed.getRandomSeed({ (result) in
            self.generateView.isLoading = false
            self.generateView.seed = result?.seed
        }) { (error) in
            self.generateView.isLoading = false
            let errorCode = (error?.code)!
            UIAlertController.showAlert("\(errorCode)", error?.message, "OK", self.navigationController)
        }
    }
    
    deinit {
        self.generateView.stopCountdown()
    }
}
