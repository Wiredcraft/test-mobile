//
//  Mode.swift
//  GithubUser
//
//  Created by zhaitong on 2022/3/23.
//

import Foundation
import HandyJSON

class BaseMode: HandyJSON {
    required init() {}
}

class ListMode: BaseMode {
    var total_count: Int = 0
    var incomplete_results: Bool = false
    var items: Array<ListItem>?
}


class ListItem: BaseMode {
    var id: Int?
    var login: String?
    var html_url: String?
    var avatar_url: String?
    var score: Int?
    var isFollow: Bool = false
}


class RepoMode: BaseMode {
    var name:String?
    var stargazers_count:Int = 0
    var html_url:String?
    var owner:OwnerMode?
}

class OwnerMode: BaseMode {
    var avatar_url: String?
}

