//
//  GULUtility.swift
//  GithubUsersList
//
//  Created by 裘诚翔 on 2021/3/6.
//

import Foundation


public func map<T:Codable>(from json: String, type: T.Type) -> T? {
    guard let jsonData = json.data(using: .utf8) else {
        return nil
    }
    return try? JSONDecoder().decode(type, from: jsonData)
}
