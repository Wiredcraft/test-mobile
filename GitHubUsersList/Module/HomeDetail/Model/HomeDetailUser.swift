//
//  HomeUserModelFrame.swift
//  GitHubUsersList
//
//  Created by YUI on 2022/3/28.
//

import UIKit

import SwiftyJSON

struct HomeDetailUser {
    
    let name: String
    let score: String
    let avatarURLStr: String
    let urlStr: String
    
    init( jsonData : JSON) {
        
        self.name = jsonData["name"].stringValue
        self.score = jsonData["stargazers_count"].stringValue
        self.avatarURLStr = jsonData["owner"]["avatar_url"].stringValue
        self.urlStr = jsonData["html_url"].stringValue
    }
}
