//
//  UserCellViewModel.swift
//  GithubClient
//
//  Created by Apple on 2020/7/21.
//  Copyright © 2020 Pszertlek. All rights reserved.
//

import Foundation

final class UserCellViewModel {
    let avatar: URL
    let name: String
    let score: String
    let html: String
    let user: GithubUser
    
    init(_ user: GithubUser) {
        self.user = user
        self.avatar = user.avatarUrl
        self.name = user.login
        self.score = "\(user.score)"
        self.html = user.htmlUrl
    }
}
