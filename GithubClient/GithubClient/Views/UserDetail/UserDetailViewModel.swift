//
//  UserDetail.swift
//  GithubClient
//
//  Created by Apple on 2020/7/22.
//  Copyright © 2020 Pszertlek. All rights reserved.
//

import Foundation

class UserDetailViewModel {
    
    private var user: GithubUser
    
    var homeUrl: URL {
        return URL(string:self.user.htmlUrl)!
    }
    
    var title: String {
        return self.user.login
    }
    
    init(_ user: GithubUser) {
        self.user = user
    }
    
}
