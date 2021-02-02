//
//  MoyaBase.swift
//  Users
//
//  Created by ivan on 2021/1/31.
//  Copyright © 2021 none. All rights reserved.
//

import Foundation
import Moya

enum GithubApi {
    // search users  q: the query content , page: page index, start from 1
    case searchUsers(query: String, page: Int = 1)
}

extension GithubApi: TargetType {

    var baseURL: URL {
        return ConfigurationManager.shared.getBaseUrl()
    }
    var path: String {
        switch self {
        case .searchUsers:
            return "/search/users"
        }
    }
    var method: Moya.Method {
        return .get
    }
    var task: Moya.Task {
        switch self {
        case let .searchUsers(query, page):
            let params = ["q": query,
                          "page": page] as [String: Any]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }

    var sampleData: Data {
        return "".data(using: .utf8) ?? Data()
    }

    var headers: [String: String]? {
        return nil
    }
}
