//
//  MockUsersListUseCase.swift
//  GitHub-Users-List-AppTests
//
//  Created by 邹奂霖 on 2022/5/12.
//


@testable import GitHub_Users_List_App
import XCTest
class MockUsersListUseCase: UsersListUseCase {
    var expectation: XCTestExpectation?
    var error: Error?
    var page = UsersListPage(incompleteResults: true, items: [], totalCount: 0)
    func excute(requestValue: UsersQueryUseCaseRequestValue, completion: @escaping (Result<UsersListPage, Error>) -> Void) -> Cancellable? {
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(page))
        }
        if let expectation = expectation {
            expectation.fulfill()
        }

        return nil
    }
}
