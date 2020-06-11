//
//  WCConstants.swift
//  Wiredcraft
//
//  Created by codeLocker on 2020/6/10.
//  Copyright © 2020 codeLocker. All rights reserved.
//

import UIKit

/*
 WCConstants is used to define constant data that is common in some projects
 such as color、font、hint .etc
 */
public struct WCConstants {
    
    /// define some common colors used in project
    struct colors {
        
        /// the main tone of the app
        static let main: UIColor = UIColor.es_hex("#1296db")
        
        /// the common color for text
        static let text: UIColor = UIColor.es_hex("#333333")
    }
    
    /// define some common fonts used in project
    struct font {
    
        /// the font of title
        static let title: UIFont = UIFont.es_pingFangSC(type: .medium, size: 16)
        
        /// the font of subtitle
        static let subtitle: UIFont = UIFont.es_pingFangSC(type: .regular, size: 14)
    }
}

/*
here is used to define configuration for the project
such as server environment、 build type、enable log .etc
*/

/// the config of server environment
public enum WCServerEnvironment: String {
    case develop = "https://api.github.com/" // server url for develop environment
    case test = "test"                       // server url for test environment
    case product = "prodcut"                 // server url for product environment
}

extension WCConstants {
    
    /// current server address
    static var currentServerUrl: String {
        get {
            return WCConstants.currentServerEnvironment.rawValue
        }
    }
    
    /// decide whether to print network log
    /// YES: print    NO: don't print
    /// develop environment print default, test and product environment print default,
    static var enableNetworkLog: Bool {
        get {
            switch WCConstants.currentServerEnvironment {
            case .develop:
                return true
            case .test:
                fallthrough
            case .product:
                return false
            }
        }
    }
    
    /// you can modify to set the project's server environment
    /// options: .develop .test .product
    static let currentServerEnvironment: WCServerEnvironment = .develop
    
}


