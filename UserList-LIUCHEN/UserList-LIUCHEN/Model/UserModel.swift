//
//  userModel.swift
//  UserList-LIUCHEN
//
//  Created by LC on 2020/6/23.
//  Copyright © 2020 LC. All rights reserved.
//

import Foundation

struct UserModel: Codable {
    var total_count: Int? = 0
    var incomplete_results: Bool = false
    var items: [Item]?
}

struct Item: Codable {
    var login: String? = ""
    var avatar_url: String? = ""
    var url: String? = ""
    var html_url: String? = ""
    var score: Double? = 0.0
    var isLoaded: Bool? = false
}
