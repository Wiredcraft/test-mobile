//
//  NetworkService.swift
//  GitHubUsers
//
//  Created by lusheng tan on 2019/4/10.
//  Copyright © 2019 lusheng tan. All rights reserved.
//

import Moya

enum APIManager {
    case SwiftUsers(Int)
    case SearchUsers(String)
}

extension APIManager: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .SwiftUsers,.SearchUsers:
            return "search/users"
        }
        
    }
    
    var method: Method {
        switch self {
        case .SwiftUsers, .SearchUsers:
            return .get
        }
    }
    // for test
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .SwiftUsers(let page):
            return .requestParameters(parameters: ["q":"swift","page":page], encoding: URLEncoding.default)
        case .SearchUsers(let keyWord):
            return .requestParameters(parameters: ["q":keyWord], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
