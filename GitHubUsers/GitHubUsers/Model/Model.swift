//
//  Model.swift
//  GitHubUsers
//
//  Created by lusheng tan on 2019/4/10.
//  Copyright © 2019 lusheng tan. All rights reserved.
//

// home
struct HomeResult: Codable {
    var total_count: Int
    var items: [User]
}

struct User: Codable {
    var login: String
    var avatar_url: String
    var html_url: String
}
