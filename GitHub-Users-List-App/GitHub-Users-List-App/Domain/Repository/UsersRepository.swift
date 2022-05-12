//
//  UsersRepository.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/7.
//

import Foundation
protocol UsersRepository {
    /// Fetch users list
    /// - Parameters:
    ///   - query: user list request query
    ///   - completion: closure for pass result
    /// - Returns: instance of cancellable
    func fectchUsersList(query: UsersQueryUseCaseRequestValue, completion: @escaping (Result<UsersListPage, Error>) -> Void) -> Cancellable?
}
