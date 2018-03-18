//
//  MainViewController.swift
//  QRApp
//
//  Created by Ville Välimaa on 17/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import UIKit

typealias ActionButtonConfigurator = (title: String, image: UIImage?)

class MainViewController: QRBaseViewController, ActionButtonViewDelegate {

    var buttonActionView: ActionButtonView?
    
    var menuConfigurator: [ActionButtonConfigurator] {
        return [
            ActionButtonConfigurator(title: "Get QR", image: UIImage(named: "qr")),
            ActionButtonConfigurator(title: "Scan QR", image: UIImage(named: "scan"))
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "QR Application"
        
//        backend.getQRCodeRandomSeed().onSuccess { dict in
//            print(BaseDictModel(dict).subModel("headers").stringOrEmpty("Connection"))
//        }
        
        buttonActionView = ActionButtonView(superview: view, delegate: self)
    }
    
    func numberOfButtonsInButtonActionView(_ buttonActionView: ActionButtonView) -> Int {
        return menuConfigurator.count
    }
    
    func actionButtonView(_ buttonActionView: ActionButtonView, didSelectButtonAtIndex index: Int) {
        print(index)
    }
    
    func actionButtonView(_ buttonActionView: ActionButtonView, titleForButtonAtIndex index: Int) -> String? {
        return menuConfigurator[index].title
    }
    
    func actionButtonView(_ buttonActionView: ActionButtonView, imageForButtonAtIndex index: Int) -> UIImage? {
        return menuConfigurator[index].image
    }
}
