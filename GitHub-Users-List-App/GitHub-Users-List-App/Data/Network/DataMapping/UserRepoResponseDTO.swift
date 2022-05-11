//
//  UserRepoResponseDTO.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/11.
//

import Foundation
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
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        htmlUrl = try values.decodeIfPresent(String.self, forKey: .htmlUrl) ?? ""
//        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? -1
//        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
//        owner = try RepoOwnerDTO(from: decoder)
//        stargazersCount = try values.decodeIfPresent(Int.self, forKey: .stargazersCount) ?? 0
//    }
}

extension UserRepoResponseDTO {
    func toDomain() -> UserRepo {
        return UserRepo(name: name, owner: owner.toDomain(), stargazersCount: stargazersCount, htmlUrl: htmlUrl, id: id)
    }
}

struct RepoOwnerDTO: Codable {
    let avatarUrl : String
    let id : Int

    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case id = "id"
    }

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        avatarUrl = try values.decodeIfPresent(String.self, forKey: .avatarUrl) ?? ""
//        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? -1
//    }
}

extension RepoOwnerDTO {
    func toDomain() -> Owner {
        return Owner(avatarUrl: avatarUrl, id: id)
    }
}
