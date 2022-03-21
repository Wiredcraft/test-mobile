//
//  Network.swift
//  test_mobile
//
//  Created by Jun Ma on 2022/3/18.
//

import Foundation
import Moya

enum Network {
    // get repos with user name
    case repos(user: String)
    // search users with keyword
    case searchUsers(keyword: String, page: Int = 1)
    
    static let provider = MoyaProvider<Network>()
}

extension Network: Moya.TargetType {
    var baseURL: URL {
        URL(string: "https://api.github.com/")!
    }
    
    var path: String {
        switch self {
        case .repos(let user):
            return "users/\(user)/repos"
        case .searchUsers:
            return "search/users"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self {
        case .repos:
            return .requestPlain
        case let .searchUsers(keyword, page):
            let params = [
                "q": keyword,
                "page": page
            ] as [String : Any]
            
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var validationType: Moya.ValidationType {
        .successCodes
    }
}
