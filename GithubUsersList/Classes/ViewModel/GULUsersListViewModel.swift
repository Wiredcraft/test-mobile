//
//  GDHomeViewModel.swift
//  GithubDemo
//
//  Created by 裘诚翔 on 2021/3/3.
//

import Foundation
import Moya
import RxSwift

struct GULUsersListViewModel {
    let provider = MoyaProvider<GULService>()
}
