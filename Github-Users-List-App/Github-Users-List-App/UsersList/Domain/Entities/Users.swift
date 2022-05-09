//
//  Users.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/9.
//

import Foundation
struct UsersListResponse : Codable {

    let incompleteResults : Bool?
    let items : [User]?
    let totalCount : Int?


    enum CodingKeys: String, CodingKey {
        case incompleteResults = "incomplete_results"
        case items = "items"
        case totalCount = "total_count"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        incompleteResults = try values.decodeIfPresent(Bool.self, forKey: .incompleteResults)
        items = try values.decodeIfPresent([User].self, forKey: .items)
        totalCount = try values.decodeIfPresent(Int.self, forKey: .totalCount)
    }


}

struct User : Codable {

    let avatarUrl : String?
    let eventsUrl : String?
    let followersUrl : String?
    let followingUrl : String?
    let gistsUrl : String?
    let gravatarId : String?
    let htmlUrl : String?
    let id : Int?
    let login : String?
    let nodeId : String?
    let organizationsUrl : String?
    let receivedEventsUrl : String?
    let reposUrl : String?
    let score : Float?
    let siteAdmin : Bool?
    let starredUrl : String?
    let subscriptionsUrl : String?
    let type : String?
    let url : String?


    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case eventsUrl = "events_url"
        case followersUrl = "followers_url"
        case followingUrl = "following_url"
        case gistsUrl = "gists_url"
        case gravatarId = "gravatar_id"
        case htmlUrl = "html_url"
        case id = "id"
        case login = "login"
        case nodeId = "node_id"
        case organizationsUrl = "organizations_url"
        case receivedEventsUrl = "received_events_url"
        case reposUrl = "repos_url"
        case score = "score"
        case siteAdmin = "site_admin"
        case starredUrl = "starred_url"
        case subscriptionsUrl = "subscriptions_url"
        case type = "type"
        case url = "url"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        avatarUrl = try values.decodeIfPresent(String.self, forKey: .avatarUrl)
        eventsUrl = try values.decodeIfPresent(String.self, forKey: .eventsUrl)
        followersUrl = try values.decodeIfPresent(String.self, forKey: .followersUrl)
        followingUrl = try values.decodeIfPresent(String.self, forKey: .followingUrl)
        gistsUrl = try values.decodeIfPresent(String.self, forKey: .gistsUrl)
        gravatarId = try values.decodeIfPresent(String.self, forKey: .gravatarId)
        htmlUrl = try values.decodeIfPresent(String.self, forKey: .htmlUrl)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        login = try values.decodeIfPresent(String.self, forKey: .login)
        nodeId = try values.decodeIfPresent(String.self, forKey: .nodeId)
        organizationsUrl = try values.decodeIfPresent(String.self, forKey: .organizationsUrl)
        receivedEventsUrl = try values.decodeIfPresent(String.self, forKey: .receivedEventsUrl)
        reposUrl = try values.decodeIfPresent(String.self, forKey: .reposUrl)
        score = try values.decodeIfPresent(Float.self, forKey: .score)
        siteAdmin = try values.decodeIfPresent(Bool.self, forKey: .siteAdmin)
        starredUrl = try values.decodeIfPresent(String.self, forKey: .starredUrl)
        subscriptionsUrl = try values.decodeIfPresent(String.self, forKey: .subscriptionsUrl)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }


}
