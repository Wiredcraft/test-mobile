//
//  QRBaseViewController.swift
//  QRApp
//
//  Created by Ville Välimaa on 14/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import UIKit

/// The abstract base class for view controllers in this app.
///
class QRBaseViewController: UIViewController {

    let backend: Backend
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    init(backend: Backend) {
        self.backend = backend
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        backend.getQRCodeRandomSeed().onSuccess { dict in
            print(BaseDictModel(dict).subModel("headers").stringOrEmpty("Connection"))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateNavBarAppearance()
    }
    
    private func updateNavBarAppearance() {
        guard let navBar = navigationController?.navigationBar else {
            return
        }
        navBar.tintColor = .white
        navBar.barTintColor = .darkBlue
        navBar.isTranslucent = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
