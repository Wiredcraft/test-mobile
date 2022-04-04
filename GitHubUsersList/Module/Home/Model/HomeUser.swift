//
//  HomeUserModelFrame.swift
//  GitHubUsersList
//
//  Created by YUI on 2022/3/28.
//

import UIKit

import SwiftyJSON

struct HomeUser {
    
    let name: String
    let score: String
    let avatarURLStr: String
    var isFollow = false
    let urlStr: String
    
    init( jsonData : JSON) {
        
        self.name = jsonData["login"].stringValue
        self.score = jsonData["score"].stringValue
        self.avatarURLStr = jsonData["avatar_url"].stringValue
        self.isFollow = jsonData["isFollow"].boolValue
        self.urlStr = jsonData["html_url"].stringValue
    }
}
