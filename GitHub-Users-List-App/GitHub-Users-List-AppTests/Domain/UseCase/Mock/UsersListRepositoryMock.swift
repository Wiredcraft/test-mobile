//
//  UsersListRepositoryMock.swift
//  GitHub-Users-List-AppTests
//
//  Created by 邹奂霖 on 2022/5/12.
//

import Foundation
@testable import GitHub_Users_List_App

class MockUsersListRepository: UsersRepository {
    var result: Result<UsersListPage, Error>
    init(result: Result<UsersListPage, Error>) {
        self.result = result
    }
    func fectchUsersList(query: UsersQueryUseCaseRequestValue, completion: @escaping (Result<UsersListPage, Error>) -> Void) -> Cancellable? {
        completion(result)
        return nil
    }
}
