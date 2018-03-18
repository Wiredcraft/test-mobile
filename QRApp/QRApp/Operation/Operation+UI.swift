//
//  Operation+UI.swift
//  QRApp
//
//  Created by Ville Välimaa on 17/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import Foundation

/// Operation extensions to bind events to UI
///
public extension Operation {
    
    @discardableResult
    func displayErrorOnUI() -> Self {
        _ = onFailure(DispatchQueue.main.context) { error in
            print("error")
        }
        return self
    }
    
    func bindToLoadingIndicator(_ indicator: LoadingProtocol) -> Self {
        return onLoadingStateChange { state in
            state ? indicator.start() : indicator.stop()
        }
    }
}

