//
//  GULNetwork.swift
//  GithubUsersList
//
//  Created by 裘诚翔 on 2021/3/6.
//

import Foundation
import Moya

enum GULService {
    case usersList(query: String, page: Int)
}


extension GULService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .usersList(_, _):
            return "/search/users"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .usersList(_, _):
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .usersList(_, _):
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        case .usersList(let query, let page):
            return .requestParameters(parameters: ["q":query,"page":page], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
}
