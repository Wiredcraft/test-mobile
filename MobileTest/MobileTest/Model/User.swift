//
//  User.swift
//  MobileTest
//
//  Created by yanjun lee on 2022/3/26.
//

import Foundation

class UserItems: Codable {
    
    let totalCount: Int
    let items: [UserModel]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"        
        case items = "items"
    }
}



class UserModel: Codable {
    
    let id: Int
    let userName: String
    let score: Double
    let htmlUrl: String
    let avator: String
    
    var isfollowing: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userName = "login"
        case score = "score"
        case htmlUrl = "html_url"
        case avator = "avatar_url"
    }
}

extension UserModel {
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
}



class UserServerResponse: Codable {
    let message: String
    let userId: Int
    
    enum CodingKeys: String, CodingKey {
        case message
        case userId = "user_id"
    }
}

typealias UsersResponse = [UserModel]
