//
//  DomainProtocols.swift
//  QRApp
//
//  Created by Ville Välimaa on 28/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

/// Something that can expire.
///
public protocol Expirable {
    func hasExpired() -> Bool
}
