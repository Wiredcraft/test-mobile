//
//  MockUserDetailUseCase.swift
//  GitHub-Users-List-AppTests
//
//  Created by 邹奂霖 on 2022/5/12.
//

import XCTest
@testable import GitHub_Users_List_App
class MockUserDetailUseCase: UserDetailUseCase {
    var expectation: XCTestExpectation?
    var error: Error?
    var repos: [UserRepo] = []
    func excute(requestValue: UserRepoRequestValue, completion: @escaping (Result<[UserRepo], Error>) -> Void) -> Cancellable? {
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(repos))
        }
        if let expectation = expectation {
            expectation.fulfill()
        }

        return nil
    }
}
