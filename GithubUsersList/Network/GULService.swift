//
//  GULNetwork.swift
//  GithubUsersList
//
//  Created by 裘诚翔 on 2021/3/6.
//

import Foundation
import Moya

enum GULService {
    case usersList(Int)
}


extension GULService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .usersList(_):
            return "/search/users"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .usersList(_):
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .usersList(_):
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        case .usersList(let page):
            return .requestParameters(parameters: ["q":"swift","page":page], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
}
