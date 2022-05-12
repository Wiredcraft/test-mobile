//
//  UsersDetailRepositoryMock.swift
//  GitHub-Users-List-AppTests
//
//  Created by 邹奂霖 on 2022/5/12.
//

import Foundation
@testable import GitHub_Users_List_App

class UsersDetailRepositoryMock: UserDetailRepository {
    var result: Result<[UserRepo], Error>
    init(result: Result<[UserRepo], Error>) {
        self.result = result
    }
    func fetchUserDetailRepos(with userName: String, completion: @escaping (Result<[UserRepo], Error>) -> Void) -> Cancellable? {
        completion(result)
        return nil
    }
}
