//
//  HomeRequest.swift
//  GitHubUsersList
//
//  Created by YUI on 2022/3/28.
//

import UIKit

class HomeDetailRequest: CommonRequest {

    init(page: Int){
        
        super.init()
        
        rootURLStr = "https://api.github.com"
        requestURLStr = "/users/swift/repos?q=swift&page=" + String(page)
    }
    
    override func requestMethod() -> YTKRequestMethod{
        
        return YTKRequestMethod.GET
    }
}
