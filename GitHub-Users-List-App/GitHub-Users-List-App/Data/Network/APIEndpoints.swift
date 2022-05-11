//
//  APIEndpoints.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/10.
//

import Foundation
struct APIEndpoints {
    static func getUsers(with usersListRequestDTO: UsersRequestDTO) -> Endpoint<UsersListResponseDTO> {
        return Endpoint(path: "search/users", method: .get, queryParametersEncodable: usersListRequestDTO)
    }
    static func getUserRepos(with requestDTO: UserRepoRequestDTO) -> Endpoint<[UserRepoResponseDTO]> {
        return Endpoint(path: "users/\(requestDTO.userName)/repos", method: .get)
    }
}
