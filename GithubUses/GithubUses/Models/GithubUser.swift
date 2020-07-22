//
//  GithubUser.swift
//  GithubUses
//
//  Created by Apple on 2020/7/20.
//

import Foundation

struct GithubUser: Codable,Identifiable {
    var id: Int
    var login: String
    var nodeId: String
    var avatarUrl: URL
    var gravatarId: String
    var url: String
    var htmlUrl: String
    var followersUrl: String
    var followingUrl: String
    var gistsUrl: String
    var starredUrl: String
    var subscriptionsUrl: String
    var organizationsUrl: String
    var reposUrl: String
    var eventsUrl: String
    var receivedEventsUrl: String
    var type: String
    var siteAdmin: Bool
    var score: Float
}


struct GithubSearchResult: Codable {
    var totalCount: Int
    var incompleteResults: Bool
    var items: [GithubUser]
}
