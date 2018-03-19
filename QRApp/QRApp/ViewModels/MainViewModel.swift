//
//  MainViewModel.swift
//  QRApp
//
//  Created by Ville Välimaa on 19/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import UIKit

class MainViewModel: QRBaseViewModel {
    
    typealias ActionButtonConfigurator = (title: String, image: UIImage?, getTargetVC: (Backend) -> QRBaseViewController)
    
    /// Simple configurator, which provides functionality and interface for each action button.
    /// Target ViewControllers are passed as closures to prevent unintentional initialization
    /// and minimize memory/performance overhead.
    ///
    var menuConfigurator: [ActionButtonConfigurator] {
        return [
            ActionButtonConfigurator(
                title: "Get QR",
                image: UIImage(named: "qr"),
                getTargetVC: { be in return DisplayQRViewController(backend: be) }),
            
            ActionButtonConfigurator(
                title: "Scan QR",
                image: UIImage(named: "scan"),
                getTargetVC: { be in return ScanQRViewController(backend: be) })
        ]
    }
    
}
