//
//  Operation+UI.swift
//  QRApp
//
//  Created by Ville Välimaa on 17/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import UIKit

/// Operation extensions to bind events to UI
///
public extension Operation {
    
    @discardableResult
    func bindToLoadingIndicator(_ indicator: LoadingProtocol) -> Self {
        return onLoadingStateChange { state in
            state ? indicator.start() : indicator.stop()
        }
    }
    
    @discardableResult
    func showErrorOnFailure(_ vc: UIViewController) -> Self {
        _ = onFailure(DispatchQueue.main.context, callback: { error in
            Alert.showOKAlert("Error!", message: error.errorDescription, showIn: vc)
        })
        return self
    }
}
