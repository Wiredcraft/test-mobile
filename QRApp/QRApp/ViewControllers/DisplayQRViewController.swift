//
//  DisplayQRViewController.swift
//  QRApp
//
//  Created by Ville Välimaa on 17/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import UIKit

class DisplayQRViewController: QRBaseViewController {
    
    private let imageView = UIImageView()
    
    private let QRCodeSize = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Display QR VC"
        
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(QRCodeSize)
            make.center.equalTo(view)
        }
        
        imageView.image = QRCode(text: "Hello world!")?.asUIImageScaledTo(size: QRCodeSize)
    }
}
