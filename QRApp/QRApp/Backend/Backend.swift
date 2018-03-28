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
            return "http://localhost:3000"
        } else {
            return "http://localhost:3000"
        }
    }
    
    
    func generateURLFromPath(_ components: String...) -> URL? {
        return components
            .map { $0.urlEncode() }
            .addToBeginning(baseURL)
            .joined(separator: "/")
            .asURL()
    }
    
    func getQRCodeRandomSeed() -> AsyncOperation<QRMembership> {
        return backendService.jsonRequest(generateURLFromPath("seed")).flatMap { dict in
            AsyncOperation { complete in
                let baseDict = BaseDictModel(dict)
                guard
                    let seed = baseDict.string("seed"),
                    let expires_at = baseDict.string("expires_at") else {
                        return complete(.failure(AppError.makeUnknownError()))
                }
                return complete(.success(QRMembership(seed: seed, expires_at: expires_at)))
            }
        }
    }
}
