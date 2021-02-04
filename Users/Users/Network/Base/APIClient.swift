//
//  APIClient.swift
//  Users
//
//  Created by ivan on 2021/1/31.
//  Copyright © 2021 none. All rights reserved.
//

import Foundation
import Moya

class APIClient: Networkable {
    // MARK: Shared instance
    static let shared = APIClient()

    var provider = MoyaProvider<GithubApi>(plugins: [NetworkLoggerPlugin()])

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
                completion(.success(usersResult))
            } catch let err {
                completion(.error(.noData))
            }
            case let .failure(err):
                print("getUsers " + err.localizedDescription)
                completion(.error(.failNetwork))
            }
        }
    }
}
