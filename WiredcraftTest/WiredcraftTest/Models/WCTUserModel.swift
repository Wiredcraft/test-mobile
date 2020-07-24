//
//  userModel.swift
//  WiredcraftTest
//
//  Created by Richard on 2020/7/21.
//  Copyright © 2020 RichardSheng. All rights reserved.
//

import Foundation
import ObjectMapper
/*
 
 Sample JSON Data
 
 "login": "swift",
 "id": 50235,
 "node_id": "MDEyOk9yZ2FuaXphdGlvbjUwMjM1",
 "avatar_url": "https://avatars2.githubusercontent.com/u/50235?v=4",
 "gravatar_id": "",
 "url": "https://api.github.com/users/swift",
 "html_url": "https://github.com/swift",
 "followers_url": "https://api.github.com/users/swift/followers",
 "following_url": "https://api.github.com/users/swift/following{/other_user}",
 "gists_url": "https://api.github.com/users/swift/gists{/gist_id}",
 "starred_url": "https://api.github.com/users/swift/starred{/owner}{/repo}",
 "subscriptions_url": "https://api.github.com/users/swift/subscriptions",
 "organizations_url": "https://api.github.com/users/swift/orgs",
 "repos_url": "https://api.github.com/users/swift/repos",
 "events_url": "https://api.github.com/users/swift/events{/privacy}",
 "received_events_url": "https://api.github.com/users/swift/received_events",
 "type": "Organization",
 "site_admin": false,
 "score": 1.0
*/
class WCTUserModel: Mappable {
  var login: String?
  var id: Int?
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
  var score: Float?
  
  required init?(map: Map) {
    
  }
  
  func mapping(map: Map) {
    login <- map["login"]
    id <- map["id"]
    node_id <- map["node_id"]
    avatar_url <- map["avatar_url"]
    gravatar_id <- map["gravatar_id"]
    url <- map["url"]
    html_url <- map["html_url"]
    followers_url <- map["followers_url"]
    following_url <- map["following_url"]
    gists_url <- map["gists_url"]
    starred_url <- map["starred_url"]
    subscriptions_url <- map["subscriptions_url"]
    organizations_url <- map["organizations_url"]
    repos_url <- map["repos_url"]
    events_url <- map["events_url"]
    received_events_url <- map["received_events_url"]
    type <- map["type"]
    site_admin <- map["site_admin"]
    score <- map["score"]
  }
  
}
