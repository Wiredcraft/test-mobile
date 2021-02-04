//
//  APIClient.swift
//  Users
//
//  Created by ivan on 2021/1/31.
//  Copyright © 2021 none. All rights reserved.
//

import Foundation
import Moya

class FakeAPIClient: NSObject {

    static let shared = FakeAPIClient()

    /// mock the response user data, the login name is long
    /// - Parameters:
    ///   - query: query keyword
    ///   - page: index page, start from index 1
    ///   - completion: success  [items: [{..}, {..}]]
    func getUsers(query: String, page: Int, completion: @escaping (NetworkResult<SearchUsersResponse>) -> Void) {

        let users = [GithubUser(id: 1, avatarURL: "https://avatars.githubusercontent.com/u/50235?v=4",
                                htmlURL: "https://github.com/swift",
                                login: "nacoq1u0q 4921bcqwer9q2934512kczskjvbqr12`nm.aksdmgv;asmdfadfa1231tnkejwnvjka",
                                score: 2,
                                scoreStr: "2")]
        let usersResult: GHResponse<SearchUsersResponse> = GHResponse(code: nil, result: SearchUsersResponse(messgae: nil, items: users))
        completion(.success(usersResult))
    }
}
