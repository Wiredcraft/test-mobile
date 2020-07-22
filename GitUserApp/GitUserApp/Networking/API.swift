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
    
    case gitHubUsers(login: String, page: Int)  //查询用户
}

let GitHubProvider = MoyaProvider<GitHubAPI>()

// 配置接口
extension GitHubAPI: TargetType {

    public var baseURL: URL {
        return URL(string: Configs.Network.kBaseUrl)!
    }
     
    public var path: String {
        switch self {
        case .gitHubUsers(_, _):
            return "/search/users"
        }
    }

    public var method: Moya.Method {
        return .get
    }

    
    public var task: Task {
        
        switch self {
        case .gitHubUsers(let login, let page):
            var params: [String: Any] = [:]
            params["q"] = login
            params["page"] = String(page)
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
       
        }
    }

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
