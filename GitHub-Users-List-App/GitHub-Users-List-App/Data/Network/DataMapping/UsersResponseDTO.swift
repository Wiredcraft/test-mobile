//
//  Users.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/9.
//

import Foundation
/// DataMapping object for UsersList response
struct UsersListResponseDTO : Codable {
    let incompleteResults : Bool?
    let items : [UserDTO]
    let totalCount : Int
    enum CodingKeys: String, CodingKey {
        case incompleteResults = "incomplete_results"
        case items = "items"
        case totalCount = "total_count"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        incompleteResults = try values.decodeIfPresent(Bool.self, forKey: .incompleteResults)
        items = try values.decodeIfPresent([UserDTO].self, forKey: .items) ?? []
        totalCount = try values.decodeIfPresent(Int.self, forKey: .totalCount) ?? 0
    }
}

extension UsersListResponseDTO {
    func toDomain() -> UsersListPage {
        return UsersListPage(incompleteResults: incompleteResults,
                                items: items.map { $0.toDomain() },
                                totalCount: totalCount)
    }
}
/// DataMapping object for User Response
struct UserDTO : Codable {
    let avatarUrl : String
    let htmlUrl : String
    let id : Int
    let login : String
    let score : Float

    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
        case id = "id"
        case login = "login"
        case score = "score"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        avatarUrl = try values.decodeIfPresent(String.self, forKey: .avatarUrl) ?? ""
        htmlUrl = try values.decodeIfPresent(String.self, forKey: .htmlUrl) ?? ""
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? -1
        login = try values.decodeIfPresent(String.self, forKey: .login) ?? ""
        score = try values.decodeIfPresent(Float.self, forKey: .score) ?? 0.0
    }
}

extension UserDTO {
    func toDomain() -> User {
        return User(avatarUrl: avatarUrl, htmlUrl: htmlUrl, id: id, login: login, score: score)
    }
}
