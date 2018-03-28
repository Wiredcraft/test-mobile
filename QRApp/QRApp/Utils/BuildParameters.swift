//
//  BuildParameters.swift
//  QRApp
//
//  Created by Ville Välimaa on 19/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

/// The type of build
///
enum BuildType {
    case development
    case release
}

struct BuildParameters {
    #if DEBUG
    static let buildType: BuildType = .development
    #else
    static let buildType: BuildType = .release
    #endif
}
