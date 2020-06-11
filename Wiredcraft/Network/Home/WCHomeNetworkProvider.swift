//
//  WCHomeNetworkProvider.swift
//  Wiredcraft
//
//  Created by codeLocker on 2020/6/11.
//  Copyright © 2020 codeLocker. All rights reserved.
//

import UIKit
import Moya

/*
 * the instance to initiate the home module‘s network request
 * if make the network log function enable, need income WCNetworkLog instance
 * else income a empty array
 */
let AMHomeProvider = MoyaProvider<WCHomeAPI>(plugins: WCConstants.enableNetworkLog ? [WCNetworkLog()] : [])

/// home module's API
enum WCHomeAPI {
    
    /// users list api
    /// - Parameters:
    ///   - query: query keyworad
    ///   - page: page number(start from 1)
    case usersList(query: String, page: Int)
}

extension WCHomeAPI: TargetType {
    
    /// the server address
    public var baseURL: URL {
        return URL.init(string: WCConstants.currentServerUrl)!
    }
    
    /// the action path of api
    public var path: String {
        switch self {
        case .usersList(_, _):
            return WCAPI.usersList.rawValue
        }
    }
    
    /// the request method for different api
    public var method: Moya.Method {
        switch self {
        case .usersList(_, _):
            return .get
        }
    }
    
    /// request header
    public var headers: [String : String]? {
        return nil
    }
    
    /// package parameters for each api task
    public var parameters: [String: Any] {
        switch self {
        case .usersList(let query, let page):
            return [
                "q": query,
                "page": page,
            ]
        }
    }
    
    /// initiate the network task
    public var task: Task {
        return .requestParameters(parameters: self.parameters, encoding: URLEncoding.default)
    }
    
    
    /// here is to make somg mock data
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
}
