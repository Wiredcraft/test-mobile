//
//  UserRepo.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/11.
//

import Foundation
struct UserRepo: Encodable, Identifiable{
    let name : String
    let owner : Owner
    let stargazersCount : Int
    let htmlUrl : String
    let id : Int
}

struct Owner: Encodable, Identifiable {
    let avatarUrl : String
    let id : Int
}
