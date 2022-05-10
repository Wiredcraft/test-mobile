//
//  UsersListUseCase.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/10.
//

import UIKit

protocol UsersListUseCase {
    func excute(completion: @escaping (Result<[User], Error>) -> Void) -> Cancellable?
}

struct UsersQueryUseCaseRequestValue {
    let q: String
    let page: Int
    func query() -> UsersQuery {
        return UsersQuery(q: q, page: page)
    }
}
final class DefaultUserListUseCase: UsersListUseCase {
    private let usersListRepository: UsersRepository
    init(usersListRepository: UsersRepository) {
        self.usersListRepository = usersListRepository
    }
    func excute(completion: @escaping (Result<[User], Error>) -> Void) -> Cancellable? {
        return usersListRepository.fectchUsersList() { result in
            completion(result)
        }

    }
}
