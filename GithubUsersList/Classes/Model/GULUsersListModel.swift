//
//  GDHomeModel.swift
//  GithubDemo
//
//  Created by 裘诚翔 on 2021/3/3.
//

import Foundation

struct GULUsersListModel: Codable {
    var total_count: Int?
    var incomplete_results: Bool?
    var items: [GULUsersListItemModel]?
}


struct GULUsersListItemModel: Codable {
    var login: String?
    var id: Int64?
    var node_id: String?
    var avatar_url: String?
    var gravatar_id: String?
    var url: String?
    var html_url: String?
    var followers_url: String?
    var following_url: String?
    var gists_url: String?
    var starred_url: String?
    var subscriptions_url: String?
    var organizations_url: String?
    var repos_url: String?
    var events_url: String?
    var received_events_url: String?
    var type: String?
    var site_admin: Bool?
    var score: Double?
}
