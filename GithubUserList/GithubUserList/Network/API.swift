//
//  API.swift
//  GithubUserList
//
//  Created by zhaotianyang on 2022/3/29.
//

import UIKit
import Moya
import RxSwift

enum ApiError: Swift.Error {
    // 服务器响应错误
    case response(code: Int, value: String)
    case noNetwork
    case handalErr(data: Any)
}

struct None: Codable { }

struct API {
    static let provider = MoyaProvider<GitHub>()
    
    static func request<T>(_ type: T.Type, api: GitHub) -> Observable<T> where T: Codable {
        return Observable.create({ (observer) -> Disposable in
            return provider.rx
                .request(api)
                .retry(5)
                .map(T.self)
                .subscribe(onSuccess: { result in
                    observer.onNext(result)
                    observer.onCompleted()
                }, onFailure: { (error) in
                    observer.onError(ApiError.response(code: -555, value: error.localizedDescription))
                })
        })
    }
}

enum GitHub {
    case searchUser([String: Any])
    case userRepositories(String)
}

extension GitHub: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .searchUser:
            return "/search/users"
        case .userRepositories(let name):
            return "/users/\(name)/repos"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .searchUser(let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .userRepositories:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
