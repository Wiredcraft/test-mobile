//
//  UserModel.swift
//  GithubUserList
//
//  Created by zhaotianyang on 2022/3/30.
//

import Foundation

struct UserPage: Codable {
    
    struct User: Codable {
        var login: String?
        var id: Int64?
        var avatar_url: String?
        var score: Double?
        var html_url: String?
        
        var isFollow: Bool {
            guard let uid = id else { return false }
            return AppGlobal.isFollowUser(id: uid)
        }
    }
    
    var items: [User]?
}

extension UserPage.User: UserItemData {
    var canFollow: Bool {
        return true
    }
}
