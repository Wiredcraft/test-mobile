//
//  LoadingIndicatorView.swift
//  QRApp
//
//  Created by Ville Välimaa on 18/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import UIKit

/// Protocol for loading indicators to provide interface
/// for operations or other actions.
///
public protocol LoadingProtocol {
    func start()
    func stop()
}

class LoadingIndicatorView: LoadingProtocol {
    
    private let loadingIndicator = with(UIActivityIndicatorView()) {
        $0.color = .black
        $0.activityIndicatorViewStyle = .gray
    }
    
    public init(superview: UIView) {
        superview.addSubview(loadingIndicator)
        loadingIndicator.center = superview.center
    }
    
    func start() {
        loadingIndicator.startAnimating()
    }
    
    func stop() {
        loadingIndicator.stopAnimating()
    }
    
}
