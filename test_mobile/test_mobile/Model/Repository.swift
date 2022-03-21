//
//  Repository.swift
//  test_mobile
//
//  Created by Jun Ma on 2022/3/18.
//

import Foundation

struct Repository: Decodable {
    let id: Int64
    let name: String
    let fullName: String
    let owner: User
    let htmlUrl: String
    let starCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, owner
        case fullName = "full_name"
        case htmlUrl = "html_url"
        case starCount = "stargazers_count"
    }
}
