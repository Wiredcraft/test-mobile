//
//  UserDetailRepositoryTests.swift
//  GitHub-Users-List-AppTests
//
//  Created by 邹奂霖 on 2022/5/12.
//

import XCTest
@testable import GitHub_Users_List_App
class UserDetailRepositoryTests: XCTestCase {

    var sut: DefaultUserDetailUseCase!
    var mockUserDetailRepository: UsersDetailRepositoryMock!
    override func setUpWithError() throws {
        try super.setUpWithError()

    }

    override func tearDownWithError() throws {
        sut = nil
        mockUserDetailRepository = nil
        try super.tearDownWithError()
    }

    // MARK: - Given
    func givenValidReponse() throws {
        let decoder = JSONDecoder()
        let validData = try Data.fromJSON(fileName: "UserRepoResponse")
        let result = try decoder.decode([UserRepoResponseDTO].self, from: validData)
        mockUserDetailRepository = UsersDetailRepositoryMock(result: .success(result.map { $0.toDomain() }))
        sut = DefaultUserDetailUseCase(repository: mockUserDetailRepository)
    }
    func testUserDetailUseCase_passValidResponse_getSuccessResponse() throws {
        try givenValidReponse()
        let expections = expectation(description: "Should get success response")
        _ = sut.excute(requestValue: .init(userName: "username"), completion: { result in
            switch result {
                case .success(_):
                    expections.fulfill()
                case.failure(_):
                    XCTFail("should not throw error")
            }
        })
        waitForExpectations(timeout: 0.1)
    }

}
