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
    
    func getQRCodeRandomSeed() -> AsyncOperation<QRMembership> {
        return backendService.jsonRequest(generateURLFromPath("delay", "0")).flatMap { dict in
            AsyncOperation { complete in
                let baseDict = BaseDictModel(dict)
                guard
                    let seed = baseDict.string("seed"),
                    let expires_at = baseDict.string("expires_at") else {
                        //return complete(.failure(AppError.makeUnknownError()))
                        return complete(.success(QRMembership(seed: "37790a1b728096b4141864f49159ad47", expires_at: "2018-03-19T18:38:01+00:00")))
                }
                //return complete(.success(QRMembership(seed: seed, expires_at: expires_at)))
                return complete(.success(QRMembership(seed: "37790a1b728096b4141864f49159ad47", expires_at: "2018-03-19T22:25:01+00:00")))
            }
        }
    }
}
