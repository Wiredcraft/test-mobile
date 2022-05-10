//
//  APIEndpoints.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/10.
//

import Foundation
struct APIEndpoints {
    static func getUsers() -> Endpoint<[User]> {
        return Endpoint(path: "users", method: .get)
    }
}
