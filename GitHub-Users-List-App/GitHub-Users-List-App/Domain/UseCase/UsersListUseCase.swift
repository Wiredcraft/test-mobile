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

final class DefaultUserListUseCase: UsersListUseCase {
    private let usersListRepository: UsersRepository

    init(usersListRepository: UsersRepository) {
        self.usersListRepository = usersListRepository
    }

    func excute(requestValue: UsersQueryUseCaseRequestValue, completion: @escaping (Result<UsersListPage, Error>) -> Void) -> Cancellable? {
        return usersListRepository.fectchUsersList(query: requestValue) { result in
            completion(result)
        }
    }
}

struct UsersQueryUseCaseRequestValue {
    let q: String
    let page: Int
    var per_page: Int = 30
    
    func query() -> UsersQuery {
        return UsersQuery(q: q, page: page, per_page: per_page)
    }
}

extension UsersQueryUseCaseRequestValue {
    func toDTO() -> UsersRequestDTO {
        return UsersRequestDTO(q: q, page: page, per_page: per_page)
    }
}
