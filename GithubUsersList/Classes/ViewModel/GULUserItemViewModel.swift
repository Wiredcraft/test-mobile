//
//  GULUserItemViewModel.swift
//  GithubUsersList
//
//  Created by 裘诚翔 on 2021/3/7.
//

import Foundation
import RxSwift
import RxRelay

struct GULUserItemViewModel {
    let name = BehaviorRelay<String?>(value: nil)
    let score = BehaviorRelay<Double?>(value: nil)
    let htmlUrl = BehaviorRelay<String?>(value: nil)
    let icon = BehaviorRelay<String?>(value: nil)
    
    init(item: GULUsersListItemModel) {
        name.accept(item.login)
        score.accept(item.score)
        htmlUrl.accept(item.html_url)
        icon.accept(item.avatar_url)
    }
}
