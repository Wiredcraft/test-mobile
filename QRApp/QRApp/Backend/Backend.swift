//
//  Backend.swift
//  QRApp
//
//  Created by Ville Välimaa on 17/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import Foundation

/// Class to handle backend actions with viewcontrollers and/or viewmodels.
///
class Backend {
    
    private let backendService = HTTPService()
    
    private var baseURL: String {
        if BuildParameters.buildType == .development {
            return "https://httpbin.org"
        } else {
            return "https://httpbin.org"
        }
    }
    
    
    func generateURLFromPath(_ components: String...) -> URL? {
        return components
            .map { $0.urlEncode() }
            .addToBeginning(baseURL)
            .joined(separator: "/")
            .asURL()
    }
    
    func getQRCodeRandomSeed() -> AsyncOperation<[String : Any]> {
        return backendService.jsonRequest(generateURLFromPath("delay", "5"))
    }
}
