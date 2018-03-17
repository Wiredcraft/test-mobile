//
//  URLResponse.swift
//  QRApp
//
//  Created by Ville Välimaa on 17/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import Foundation

public extension URLResponse {
    
    func getStatusCode() -> Int {
        return (self as? HTTPURLResponse)?.statusCode ?? 0
    }
}
