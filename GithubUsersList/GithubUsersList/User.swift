//
//  User.swift
//  GithubUsersList
//
//  Created by Rusty on 2020/10/26.
//

class UserArray: Codable {
  var total_count = 0
  var items = [Item]()
}

class Item: Codable {
  var login: String? = ""
  var score: Float = 0
  var html_url: String? = ""
}
