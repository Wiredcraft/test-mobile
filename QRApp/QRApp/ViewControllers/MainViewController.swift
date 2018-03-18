//
//  MainViewController.swift
//  QRApp
//
//  Created by Ville Välimaa on 17/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import UIKit

class MainViewController: QRBaseViewController, ActionButtonViewDelegate {

    var buttonActionView: ActionButtonView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "QR Application"
        
//        backend.getQRCodeRandomSeed().onSuccess { dict in
//            print(BaseDictModel(dict).subModel("headers").stringOrEmpty("Connection"))
//        }
        
        buttonActionView = ActionButtonView(superview: view, delegate: self)
    }
    
    func numberOfButtonsInButtonActionView(_ buttonActionView: ActionButtonView) -> Int {
        return 2
    }
    
    func actionButtonView(_ buttonActionView: ActionButtonView, didSelectButtonAtIndex index: Int) {
        print(index)
    }
    
    func actionButtonView(_ buttonActionView: ActionButtonView, titleForButtonAtIndex: Int) -> String? {
        return "Scan QR"
    }
    
    func actionButtonView(_ buttonActionView: ActionButtonView, imageForButtonAtIndex: Int) -> UIImage? {
        return nil
    }
}
