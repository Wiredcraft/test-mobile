//
//  UsersAPI.swift
//  MobileTest
//
//  Created by yanjun lee on 2022/3/26.
//

import RxSwift

protocol UsersAPI {
    func fetchUsers(q: String, page: Int) -> Single<UsersResponse>
}
