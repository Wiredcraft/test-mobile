//
//  User.swift
//  GithubUsersList
//
//  Created by Rusty on 2020/10/26.
//
import UIKit

class UserArray: Codable {
  var total_count = 0
  var users = [User]()
  
  init(total_count: Int, users: [User]) {
    self.total_count = total_count
    self.users = users
  }
  
  init() {
    self.total_count = 0
    self.users = []
  }
  
  enum CodingKeys: String, CodingKey {
    case users = "items"
    case total_count
  }
}

class User: Codable, CustomStringConvertible {
  var login: String? = ""
  var score: Float = 0
  var html_url: String? = ""
  var avatar_url: String? = ""
  
  init(login: String?, score: Float, html_url: String?, avatar_url: String) {
    self.login = login
    self.score = score
    self.html_url = html_url
    self.avatar_url = avatar_url
  }
  
  var description: String {
    return "\nItem - Login: \(login ?? ""), Score: \(score), URL: \(html_url ?? ""), AvatarURL: \(avatar_url ?? "")"
  }
}
