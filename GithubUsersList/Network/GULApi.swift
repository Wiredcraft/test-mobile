//
//  GULApi.swift
//  GithubUsersList
//
//  Created by 裘诚翔 on 2021/3/9.
//

import Foundation
import RxSwift
import Moya

protocol GULApi {
    func usersList(query: String, page: Int) -> Single<GULUsersListModel>
}

struct GULNetwork: GULApi {
    private let provider = MoyaProvider<GULService>()
    func usersList(query: String, page: Int) -> Single<GULUsersListModel> {
        return self.provider.rx.request(.usersList(query: query, page: page)).map(GULUsersListModel.self)
    }
}
