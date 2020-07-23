//
//  GithubAPI.swift
//  GithubClient
//
//  Created by Apple on 2020/7/21.
//  Copyright © 2020 Pszertlek. All rights reserved.
//

import Foundation
import Moya

public enum GitHub {
    case search(String,Int)
}

extension GitHub: TargetType {
    public var baseURL: URL { return URL(string: "https://api.github.com")! }
    public var path: String {
        switch self {
        case .search:
            return "/search/users"
        }
    }
    public var method: Moya.Method {
        return .get
    }
    public var task: Task {
        switch self {
        case let .search(query, page):
            return .requestParameters(parameters: ["q":query,"page":page], encoding: URLEncoding.default)
        }
    }
    
    public var validationType: ValidationType {
        switch self {
        default:
            return .successCodes
        }
    }
    public var sampleData: Data {
        switch self {
        case .search:
            if let url = Bundle.main.url(forResource: "users", withExtension: "json") {
                if let data = try? Data(contentsOf: url) {
                    return data
                }
            }
            return Data()
        }
    }
    public var headers: [String: String]? {
        return nil
    }
}
