//
//  UserDetailUseCase.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/11.
//

import Foundation
protocol UserDetailUseCase {
    func excute(requestValue: UserRepoRequestValue, completion: @escaping (Result<[UserRepo], Error>) -> Void) -> Cancellable?
}

final class DefaultUserDetailUseCase: UserDetailUseCase {
    private let repository: UserDetailRepository
    init(repository: UserDetailRepository) {
        self.repository = repository
    }

    func excute(requestValue: UserRepoRequestValue, completion: @escaping (Result<[UserRepo], Error>) -> Void) -> Cancellable? {
        return repository.fetchUserDetailRepos(with: requestValue.userName) { result in
            completion(result)
        }
    }
}

struct UserRepoRequestValue {
    let userName: String
}
