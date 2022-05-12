//
//  UserRepoResponseDTO.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/11.
//

import Foundation
/// DataMapping object for user's repo response
struct UserRepoResponseDTO: Codable {
    let name : String
    let owner : RepoOwnerDTO
    let stargazersCount : Int
    let htmlUrl : String
    let id : Int
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case owner
        case stargazersCount = "stargazers_count"
        case htmlUrl = "html_url"
        case id = "id"
    }
}

extension UserRepoResponseDTO {
    func toDomain() -> UserRepo {
        return UserRepo(name: name, owner: owner.toDomain(), stargazersCount: stargazersCount, htmlUrl: htmlUrl, id: id)
    }
}
/// DataMapping object for repo's owner response
struct RepoOwnerDTO: Codable {
    let avatarUrl : String
    let id : Int

    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case id = "id"
    }
}

extension RepoOwnerDTO {
    func toDomain() -> Owner {
        return Owner(avatarUrl: avatarUrl, id: id)
    }
}
