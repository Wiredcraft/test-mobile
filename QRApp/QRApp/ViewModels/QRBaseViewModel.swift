//
//  QRBaseViewModel.swift
//  QRApp
//
//  Created by Ville Välimaa on 19/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

/// Base viewmodel for viewmodels in the application.
///
class QRBaseViewModel {
    
    let backend: Backend
    
    init(backend: Backend) {
        self.backend = backend
    }
}
