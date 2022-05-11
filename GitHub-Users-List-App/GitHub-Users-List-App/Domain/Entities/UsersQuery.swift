//
//  UsersQuery.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/9.
//

import Foundation
struct UsersQuery: Equatable {
    let q: String
    let page: Int
    var per_page: Int = 30
}

extension UsersQuery {
    static let DefaultQuery = UsersQuery(q: "swift", page: 1)
    func toRequestValue() -> UsersQueryUseCaseRequestValue {
        return UsersQueryUseCaseRequestValue(q: q, page: page, per_page: per_page)
    }
}
