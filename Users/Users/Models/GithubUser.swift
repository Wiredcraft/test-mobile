//
//  GithubUser.swift
//  Users
//
//  Created by ivan on 2021/1/31.
//  Copyright © 2021 none. All rights reserved.
//

import Foundation

struct GithubUser: UserDef {
    let id: UInt
    let avatarURL: String
    let htmlURL: String
    let login: String
    let score: Double
    let scoreStr: String
}

extension GithubUser: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
        case login = "login"
        case score = "score"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UInt.self, forKey: .id)
        avatarURL = try container.decode(String.self, forKey: .avatarURL)
        htmlURL = try container.decode(String.self, forKey: .htmlURL)
        login = try container.decode(String.self, forKey: .login)
        score = try container.decode(Double.self, forKey: .score)
        scoreStr = "\(score)"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(avatarURL, forKey: .avatarURL)
        try container.encode(htmlURL, forKey: .htmlURL)
        try container.encode(login, forKey: .login)
        try container.encode(score, forKey: .score)
    }
}
