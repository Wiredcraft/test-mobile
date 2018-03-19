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
    private lazy var loadingIndicator = LoadingIndicatorView(superview: view)
    
    private let QRCodeSize = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Display QR VC"
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.size.equalTo(QRCodeSize)
            make.center.equalTo(view)
        }
        
        backend
            .getQRCodeRandomSeed()
            .bindToLoadingIndicator(loadingIndicator)
            .showErrorOnFailure(self)
            .onSuccess { [weak self] dict in
                //self?.imageView.image = UIImage.asQRCodeImageFrom(BaseDictModel(dict).subModel("headers").stringOrEmpty("Connection"), for: self?.QRCodeSize ?? 0)
                self?.imageView.image = QRCode(text: BaseDictModel(dict).subModel("headers").stringOrEmpty("Connection"))?.asWiredCraftQRImage(size: 300)
        }
    }
}
