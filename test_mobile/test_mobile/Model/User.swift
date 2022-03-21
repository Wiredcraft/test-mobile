//
//  User.swift
//  test_mobile
//
//  Created by Jun Ma on 2022/3/18.
//

import Foundation

struct User: Decodable {
    let login: String
    let id: Int64
    let avatarUrl: String
    let htmlUrl: String
    let score: Float?
    
    var followed: Bool = false
    var followedDescription: String {
        followed ? "FOLLOWED" : "FOLLOW"
    }
    
    enum CodingKeys: String, CodingKey {
        case login, id, score
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
    }
    
    mutating func followStatusTriggered() {
        followed.toggle()
    }
}
