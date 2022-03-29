//
//  UserHttpRouter.swift
//  MobileTest
//
//  Created by yanjun lee on 2022/3/26.
//


import Alamofire


enum UsersHttpRouter {
    case getUsersList(q: String, page: Int)
}

extension UsersHttpRouter: HttpRouter {
    
    var baseUrlString: String {
        return "https://api.github.com"
    }
    
    var path: String {
        switch self {
        case .getUsersList(_,_):
            return "/search/users"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUsersList(_,_) :
            return .get
        }
    }
    
    var parameters: Parameters?{
        switch self {
        case .getUsersList(let q, let page):
            return ["q":q,"page":page]
        }
    }
    
    
    var headers: HTTPHeaders? {
        return ["Content-Type": "application/json"]
    }
    
    
    func body() throws -> Data? {
        return nil
    }
}
