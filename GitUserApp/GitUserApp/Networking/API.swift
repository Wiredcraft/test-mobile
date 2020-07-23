//
//  API.swift
//  GitUserApp
//
//  Created by Rock on 7/22/20.
//  Copyright © 2020 Rock. All rights reserved.
//

import Foundation
import Moya

/// API
public enum GitHubAPI {
    case gitHubUsers(login: String, page: Int)
}


/// Moya Provider
let gitHubProvider = MoyaProvider<GitHubAPI>()

/// configure API
extension GitHubAPI: TargetType {

    public var baseURL: URL {
        return URL(string: Configs.Network.kBaseUrl)!
    }
     
    public var path: String {
        
        switch self {
            
        /// api : search users
        case .gitHubUsers(_, _):
            return "/search/users"
        }
    }

    public var method: Moya.Method {
        
        switch self {
        case .gitHubUsers(_, _):
            return .get
        }
    }

    public var task: Task {
        
        switch self {
            
        /// task : search users
        case .gitHubUsers(let login, let page):
            var params: [String: Any] = [:]
            params["q"] = login
            params["page"] = String(page)
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)

        }
    }

    /// Alamofire validate
    public var validate: Bool {
        return false
    }
     
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }

    public var headers: [String: String]? {
        return nil
    }
}
