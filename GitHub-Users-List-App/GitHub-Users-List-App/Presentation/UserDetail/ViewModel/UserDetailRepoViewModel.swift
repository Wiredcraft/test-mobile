//
//  UserDetailRepoViewModel.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/11.
//

import Foundation
class UserDetailRepoViewModel {
    let name: String
    let avatarURL: URL?
    let score: String
    let htmlURL: String

    let repo: UserRepo
    init(repo: UserRepo) {
        self.repo = repo
        self.name = repo.name
        self.avatarURL = URL(string: repo.owner.avatarUrl)
        self.score = "\(repo.stargazersCount)"
        self.htmlURL = repo.htmlUrl
    }
}
