//
//  UsersListPage.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/10.
//

import Foundation
struct UsersListPage: Equatable {
    let incompleteResults : Bool?
    let items : [User]
    let totalCount : Int
}

struct User: Equatable, Identifiable {
    let avatarUrl : String
    let htmlUrl : String
    let id : Int
    let login : String
    let score : Float
}
