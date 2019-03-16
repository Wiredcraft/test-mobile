//
//  HomeViewController.swift
//  QRCodeTool
//
//  Created by 彭柯柱 on 2019/3/16.
//  Copyright © 2019 彭柯柱. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    var scanButton : UIButton?      //scan QR code
    var generateButton : UIButton?  //generate QR code
    var moreButton : UIButton?      //show detail opeations
    let themeColor = UIColor.init(red: 50.0 / 255.0, green: 120.0 / 255.0, blue: 240.0 / 255.0, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Home"
        self.loadSubViews()
    }
    
    func loadSubViews() {
        self.moreButton = UIButton.init(type: .custom)
        self.moreButton?.setTitle("+", for: .normal)
        self.moreButton?.setTitleColor(.white, for: .normal)
        self.moreButton?.backgroundColor = themeColor
        self.view.addSubview(self.moreButton!)
        self.moreButton?.snp.makeConstraints({ (maker) in
            maker.size.equalTo(CGSize.init(width: 55, height: 55))
            maker.bottom.equalToSuperview().offset(-40)
            maker.right.equalToSuperview().offset(-20)
        })

        self.scanButton = UIButton.init(type: .custom)
        self.scanButton?.setTitle("Scan", for: .normal)
        self.scanButton?.setTitleColor(.white, for: .normal)
        self.scanButton?.backgroundColor = themeColor
        self.view.addSubview(self.scanButton!)
        self.scanButton?.snp.makeConstraints({ (maker) in
            maker.edges.equalTo(self.moreButton!)
        })
        
        self.generateButton = UIButton.init(type: .custom)
        self.generateButton?.setTitle("Scan", for: .normal)
        self.generateButton?.setTitleColor(.white, for: .normal)
        self.generateButton?.backgroundColor = themeColor
        self.view.addSubview(self.generateButton!)
        self.generateButton?.snp.makeConstraints({ (maker) in
            maker.edges.equalTo(self.moreButton!)
        })
    }
}
