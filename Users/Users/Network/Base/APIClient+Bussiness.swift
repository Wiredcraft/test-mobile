//
//  Bussiness.swift
//  Users
//
//  Created by ivanzeng on 2021/2/2.
//  Copyright © 2021 none. All rights reserved.
//

import Foundation

// search Users
struct SearchUsersResponse: Codable {
    let messgae: String? // not nil when error happen
    let items: [GithubUser]
}
