//
//  UserListItemViewModel.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/10.
//

import Foundation
class UsersListItemViewModel {
    enum UserState {
        case follow, followed
    }
    let name: String?
    let avatarURL: URL?
    let score: String?
    let htmlURL: String?
    let state: UserState = .follow
    init(user: User) {
        self.name = user.login
        self.avatarURL = user.avatarUrl != nil ? URL(string: user.avatarUrl!) : nil
        self.score = "\(user.score)"
        self.htmlURL = user.htmlUrl
    }
}
