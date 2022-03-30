//
//  ReposItemModel.swift
//  GithubUserList
//
//  Created by zhaotianyang on 2022/3/31.
//

import Foundation

struct ReposItemModel: Codable {
    struct Owner: Codable {
        var avatar_url: String?
    }
    
    var name: String?
    var id: Int64?
    var owner: Owner?
    var stargazers_count: Double?
    var html_url: String?
    
    var isFollow: Bool {
        guard let uid = id else { return false }
        return AppGlobal.isFollowUser(id: uid)
    }
}

extension ReposItemModel: UserItemData {
    var login: String? {
        return name
    }
    
    var avatar_url: String? {
        return owner?.avatar_url
    }
    
    var score: Double? {
        return stargazers_count
    }
    
    var canFollow: Bool {
        return false
    }
}
