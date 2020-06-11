//
//  WCUserListModel.swift
//  Wiredcraft
//
//  Created by codeLocker on 2020/6/11.
//  Copyright © 2020 codeLocker. All rights reserved.
//

import UIKit
import ObjectMapper

/*
 * the data model of user list
 */
struct WCUserListModel: Mappable {
    
    /// the count of all users searched
    /// if the have been displayed data count == total_count, there is no more data
    var total_count: Int?
    
    /// users data for one page
    var items: [WCUserModel]?
    
    /// now use for error message
    var message: String?
    
    /// errors
    var errors: [WCUserErrorModel]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.total_count <- map["total_count"]
        self.items <- map["items"]
        self.message <- map["message"]
    }
    
}

struct WCUserModel: Mappable {
    /// user's nickname
    var login: String?
    
    /// user's id
    var id: Int?
    
    /// user's avatar
    var avatar_url: String?
    
    /// user's homepage
    var html_url: String?
    
    /// user's score
    var score: Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.login <- map["login"]
        self.id <- map["id"]
        self.avatar_url <- map["avatar_url"]
        self.html_url <- map["html_url"]
        self.score <- map["score"]
    }
    
}

/*
* network error struct
*/
struct WCUserErrorModel: Mappable {
    var field: String?
    var resource: Int?
    var code: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.field <- map["field"]
        self.resource <- map["resource"]
        self.code <- map["code"]
    }
}
