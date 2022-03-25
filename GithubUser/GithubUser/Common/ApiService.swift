//
//  ApiService.swift
//  GithubUser
//
//  Created by zhaitong on 2022/3/22.
//

import Foundation

class ApiService{
    
    /**
            获取列表
     */
    static func getList(keyWord: String?, page: Int, callback: @escaping Callback<ListMode>){
        NetRequest.GET(path: "/search/users", params: ["q":keyWord ?? "swift", "page":page], callback: callback)
    }
    
    //https://api.github.com/users/swift/followers
    
    static func followers(user: String, callback: @escaping Callback<BaseMode>){
        NetRequest.GET(path: "/users/\(user)/followers", params: nil, callback: callback)
    }
    
    
    //https://api.github.com/users/swift/repos
    
    static func repos(user: String, callback: @escaping Callback<Array<RepoMode>>){
        NetRequest.getArray(path: "/users/\(user)/repos", params: nil, callback: callback)
    }
}
