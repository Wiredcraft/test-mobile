//
//  AppGlobal.swift
//  GithubUserList
//
//  Created by zhaotianyang on 2022/3/31.
//

import Foundation
import RxSwift
import RxCocoa

enum UserFollow {
    case follow(Int64)
    case unFolllow(Int64)
}

extension UserFollow {
    var uid: Int64 {
        switch self {
        case .follow(let id):
            return id
        case .unFolllow(let id):
            return id
        }
    }
}

class AppGlobal {
    private static let standard = UserDefaults.standard
    private static let followUserKey = "followUserKey"
    
    static let followSigle = PublishSubject<UserFollow>()
    
    static func followUsers() -> [Int64] {
        let followUsers = standard.array(forKey: followUserKey) as? [Int64]
        return followUsers ?? []
    }
    
    static func followUser(id: Int64) {
        let array = followUsers()
        standard.set(array+[id], forKey: followUserKey)
        standard.synchronize()
        followSigle.onNext(UserFollow.follow(id))
    }
    
    static func unFollowUser(id: Int64) {
        var array = followUsers()
        if let index = array.firstIndex(of: id) {
            array.remove(at: index)
            standard.set(array, forKey: followUserKey)
            standard.synchronize()
            followSigle.onNext(UserFollow.unFolllow(id))
        }
    }
    
    static func isFollowUser(id: Int64) -> Bool {
        let array = followUsers()
        return array.contains(id)
    }
}
