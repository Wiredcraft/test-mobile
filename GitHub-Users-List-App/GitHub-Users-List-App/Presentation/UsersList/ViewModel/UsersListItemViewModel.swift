//
//  UserListItemViewModel.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/10.
//

import Foundation
class UsersListItemViewModel {
    var name: String
    var avatarURL: URL?
    var score: Float
    var scoreContent: String { "\(score)" }
    var htmlURL: String
    let id: Int
    var followState: User.FollowState

    init(user: User) {
        self.id = user.id
        self.name = user.login
        self.avatarURL = URL(string: user.avatarUrl) ?? nil
        self.score = user.score
        self.htmlURL = user.htmlUrl
        self.followState = user.followState
    }

    func follow() {
        followState = .followed
    }

    func unfollow() {
        followState = .normal
    }

    func user() -> User {
        return User(avatarUrl: avatarURL?.absoluteString ?? "", htmlUrl: htmlURL, id: id, login: name, score: score, followState: followState)
    }

    func update(with user: User) {
        self.name = user.login
        self.avatarURL = URL(string: user.avatarUrl) ?? nil
        self.score = user.score
        self.htmlURL = user.htmlUrl
        self.followState = user.followState
    }
}
