//
//  YBNetWorking.swift
//  GitUserApp
//
//  Created by Rock on 7/22/20.
//  Copyright © 2020 Rock. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya_ObjectMapper

class YBNetWorking {
    
    /// Search Github Users
    /// - Parameters:
    ///   - login: Users Name
    ///   - page: Page of Result
    func searchGitHubUsers(login: String, page: Int) -> Driver<GitHubUsers> {
        return gitHubProvider.rx.request(.gitHubUsers(login: login, page: page))
            .filterSuccessfulStatusCodes()
            .mapObject(GitHubUsers.self)
            .asDriver(onErrorDriveWith: Driver.empty())
            
    }
}
