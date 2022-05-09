//
//  UsersRepository.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/7.
//

import Foundation
protocol UsersRepository {
    func fectchUsersList(query: UsersQuery, completion: @escaping (Result<UsersListResponse, Error>) -> Void) -> Cancellable
}
