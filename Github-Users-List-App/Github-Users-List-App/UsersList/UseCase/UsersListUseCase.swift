//
//  UsersListUseCase.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/10.
//

import UIKit

protocol UsersListUseCase {
    func excute(requestValue: UsersQueryUseCaseRequestValue, completion: @escaping (Result<UsersListPage, Error>) -> Void) -> Cancellable?
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
    func excute(requestValue: UsersQueryUseCaseRequestValue, completion: @escaping (Result<UsersListPage, Error>) -> Void) -> Cancellable? {
        return usersListRepository.fectchUsersList(query: requestValue.query()) { result in
            completion(result)
        }
    }
}
