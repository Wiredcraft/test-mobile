//
//  APIClient.swift
//  Users
//
//  Created by ivan on 2021/1/31.
//  Copyright © 2021 none. All rights reserved.
//

import Alamofire
import Foundation
import Moya

class APIClient: Networkable {
    // MARK: Shared instance
    static let shared = APIClient()
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.github.com")
    var provider = MoyaProvider<GithubApi>(plugins: [NetworkLoggerPlugin()])
    var netAavilable: Bool {
        guard let reachabilityManager = reachabilityManager else {
            return false
        }
        return reachabilityManager.isReachable
    }

    /// request the users list due to the query keyword
    /// - Parameters:
    ///   - query: query keyword
    ///   - page: index page, start from index 1
    ///   - completion: success  [items: [{..}, {..}]]
    func getUsers(query: String, page: Int, completion: @escaping (NetworkResult<SearchUsersResponse>) -> Void) {
        provider.request(.searchUsers(query: query, page: page)) { result in
            switch result {
            case let .success(response):
            do {
                let usersResult: GHResponse<SearchUsersResponse> = try GHResponse.from(data: response.data)
                if let err = usersResult.result?.messgae {
                    completion(.error(.otherError(msg: err)))
                } else if let items = usersResult.result?.items, items.isEmpty {
                    completion(.error(.noData))
                } else {
                    completion(.success(usersResult))
                }
            } catch let err {
                print("err.localizedDescription = \(err.localizedDescription)")
                completion(.error(.otherError(msg: err.localizedDescription)))
            }
            case let .failure(err):
                print("getUsers " + err.localizedDescription)
                completion(.error(.failNetwork))
            }
        }
    }
}
