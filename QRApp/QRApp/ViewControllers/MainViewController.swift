//
//  MainViewController.swift
//  QRApp
//
//  Created by Ville Välimaa on 17/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import UIKit

typealias ActionButtonConfigurator = (title: String, image: UIImage?, getTargetVC: (Backend) -> QRBaseViewController)

class MainViewController: QRBaseViewController {
    
    // Handles ActionButton displaying and menu-like functionality
    //
    private var buttonActionView: ActionButtonView?
    
    /// Simple configurator, which provides functionality and interface for each action button.
    /// Target ViewControllers are passed as closures to prevent unintentional initialization
    /// and minimize memory/performance overhead.
    ///
    private var menuConfigurator: [ActionButtonConfigurator] {
        return [
            ActionButtonConfigurator(
                title: "Get QR",
                image: UIImage(named: "qr"),
                getTargetVC: { be in return DisplayQRViewController(backend: be) }),
            
            ActionButtonConfigurator(
                title: "Scan QR",
                image: UIImage(named: "scan"),
                getTargetVC: { be in return DisplayQRViewController(backend: be) })
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
}

/// MARK: ActionButtonViewDelegate
///
extension MainViewController: ActionButtonViewDelegate {
    
    func numberOfButtonsInButtonActionView(_ buttonActionView: ActionButtonView) -> Int {
        return menuConfigurator.count
    }
    
    func actionButtonView(_ buttonActionView: ActionButtonView, didSelectButtonAtIndex index: Int) {
        navigationController?.pushViewController(
            menuConfigurator[index].getTargetVC(backend),
            animated: true)
    }
    
    func actionButtonView(_ buttonActionView: ActionButtonView, titleForButtonAtIndex index: Int) -> String? {
        return menuConfigurator[index].title
    }
    
    func actionButtonView(_ buttonActionView: ActionButtonView, imageForButtonAtIndex index: Int) -> UIImage? {
        return menuConfigurator[index].image
    }
}
