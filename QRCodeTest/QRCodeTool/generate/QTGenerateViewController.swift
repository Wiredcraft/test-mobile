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
        
        self.loadCacheSeed()
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
            self.cacheSeed(result?.seed)
        }) { (error) in
            self.generateView.isLoading = false
            let errorCode = (error?.code)!
            UIAlertController.showAlert("\(errorCode)", error?.message, "OK", self.navigationController)
        }
    }
    
    func cacheSeed(_ seed: QTSeed?) {//userDefaults cache qr code
        UserDefaults.standard.set(seed?.seed, forKey: kUserQRCodeKey)
    }
    
    func loadCacheSeed() {//load code from userDefauls
        let cachedSeed: QTSeed = QTSeed()
        let seedStr = UserDefaults.standard.string(forKey: kUserQRCodeKey)
        cachedSeed.seed = seedStr
        self.generateView.seed = cachedSeed
    }
    
    deinit {
        self.generateView.stopCountdown()
    }
}
