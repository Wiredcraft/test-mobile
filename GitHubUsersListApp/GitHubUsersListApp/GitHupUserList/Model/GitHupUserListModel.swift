//
//  GitHupUserListModel.swift
//  CJWProject
//
//  Created by Joy Cheng on 2022/3/31.
//

import UIKit

class GitHupUserListData: SwiftyJSONAble {
    public var items: [GitHupUserListModel]
    required init?(_ jsonData: JSON) {
        items = jsonData["items"].arrayValue.compactMap(GitHupUserListModel.init)
    }
}

class GitHupUserListModel: SwiftyJSONAble {
    var id: Int
    var score: Int
    var login: String
    var avatarUrl: String
    var htmlUrl: String
    // detail code
    var stargazersCount: String
    var name: String
    var owner: FollowDetailOwner
    // local code
    var isFollowed = false
    required init?(_ jsonData: JSON) {
        id = jsonData["id"].intValue
        score = jsonData["score"].intValue
        login = jsonData["login"].stringValue
        avatarUrl = jsonData["avatar_url"].stringValue
        htmlUrl = jsonData["html_url"].stringValue
        stargazersCount = jsonData["stargazers_count"].stringValue
        name = jsonData["name"].stringValue
        owner = FollowDetailOwner(jsonData["owner"])!
    }

}
