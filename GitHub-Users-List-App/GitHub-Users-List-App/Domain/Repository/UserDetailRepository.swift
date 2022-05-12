//
//  UserDetailRepository.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/11.
//

import Foundation
protocol UserDetailRepository {
    /// fetch user's repos
    /// - Parameters:
    ///   - userName: username of user
    ///   - completion: closure for pass result
    /// - Returns: instance of Cancellable
    func fetchUserDetailRepos(with userName: String, completion: @escaping (Result<[UserRepo], Error>) -> Void) -> Cancellable?
}
