//
//  DisplayQRViewController.swift
//  QRApp
//
//  Created by Ville Välimaa on 17/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import UIKit

/// ViewController which handles loading QR membership from
/// either local cache or online service.
///
class DisplayQRViewController: QRBaseViewController {
    
    private let imageView = UIImageView()
    private lazy var loadingIndicator = LoadingIndicatorView(superview: view)
    private let QRCodeSize = 300
    
    // Property to verify membership is in cache
    // and that it is valid.
    //
    private var membershipExistsAndIsValid: Bool {
        guard
            let membership = QRUserDefaults.standard.qrMembershipInStorage,
            !(Date.dateFrom(iso8061DateString: membership.expires_at)?.hasPassed() ?? true) else {
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Display QR VC"
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.size.equalTo(QRCodeSize)
            make.center.equalTo(view)
        }
        
        membershipExistsAndIsValid ? loadMembershipFromStorage() : loadMembershipFromOnline()
    }
    
    private func loadMembershipFromOnline() {
        backend
            .getQRCodeRandomSeed()
            .bindToLoadingIndicator(loadingIndicator)
            .showErrorOnFailure(self)
            .onSuccess { [weak self] membership in
                guard let sself = self else { return }
                QRUserDefaults.standard.qrMembershipInStorage = membership
                sself.displayMembershipAsQRCode(membership)
        }
    }
    
    private func loadMembershipFromStorage() {
        guard let membership = QRUserDefaults.standard.qrMembershipInStorage else { return }
        displayMembershipAsQRCode(membership)
    }
    
    private func displayMembershipAsQRCode(_ membership: QRMembership) {
        self.imageView.image = QRCode(text: membership.seed)?.asWiredCraftQRImage(size: self.QRCodeSize)
    }
}
