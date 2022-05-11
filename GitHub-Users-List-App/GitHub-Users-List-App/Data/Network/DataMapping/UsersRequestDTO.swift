//
//  UsersRequestDTO.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/10.
//

import Foundation
struct UsersRequestDTO: Encodable {
    let q: String
    let page: Int
    var per_page: Int = 30
}
