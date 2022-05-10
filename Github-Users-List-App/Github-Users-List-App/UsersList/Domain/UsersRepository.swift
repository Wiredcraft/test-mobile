//
//  UsersRepository.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/7.
//

import Foundation
protocol UsersRepository {
    func fectchUsersList(completion: @escaping (Result<[User], Error>) -> Void) -> Cancellable
}
