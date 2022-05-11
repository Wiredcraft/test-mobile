//
//  UserListItemViewModel.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/10.
//

import Foundation
class UsersListItemViewModel {

    let name: String
    let avatarURL: URL?
    let score: String
    let htmlURL: String
    var user: User {
        didSet {
            followState = Observable(user.followState)
        }
    }
    var followState: Observable<User.FollowState>!

    init(user: User) {
        self.user = user
        self.name = user.login
        self.avatarURL = URL(string: user.avatarUrl) ?? nil
        self.score = "\(user.score)"
        self.htmlURL = user.htmlUrl
        followState = Observable(user.followState)
    }

    func follow() {
        followState.value = .followed
        user.follow()
    }
    func unfollow() {
        followState.value = .normal
        user.unfollow()
    }
}
