//
//  GitHupUserDetailModel.swift
//  CJWProject
//
//  Created by Joy Cheng on 2022/3/31.
//

import UIKit

class GitHupUserDetailSource: SwiftyJSONAble {
    public var followedItems: [GitHupUserListModel]
    required init?(_ jsonData: JSON) {
        followedItems = jsonData.arrayValue.compactMap(GitHupUserListModel.init)
    }
}

class FollowDetailOwner: SwiftyJSONAble {
    var id: Int
    var login: String
    var avatarUrl: String
    var htmlUrl: String
    required init?(_ jsonData: JSON) {
        id = jsonData["id"].intValue
        login = jsonData["login"].stringValue
        avatarUrl = jsonData["avatar_url"].stringValue
        htmlUrl = jsonData["html_url"].stringValue
    }
}
