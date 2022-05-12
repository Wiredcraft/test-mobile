//
//  UsersListUseCaseTests.swift
//  GitHub-Users-List-AppTests
//
//  Created by 邹奂霖 on 2022/5/12.
//

import XCTest
@testable import GitHub_Users_List_App
class UsersListUseCaseTests: XCTestCase {
    var sut: DefaultUserListUseCase!
    var mockUsersListRepository: MockUsersListRepository!
    override func setUpWithError() throws {
        try super.setUpWithError()

    }

    override func tearDownWithError() throws {
        sut = nil
        mockUsersListRepository = nil
        try super.tearDownWithError()
    }

    // MARK: - Given
    func givenValidReponse() throws {
        let decoder = JSONDecoder()
        let validData = try Data.fromJSON(fileName: "UsersListResponse")
        let result = try decoder.decode(UsersListResponseDTO.self, from: validData)
        mockUsersListRepository = MockUsersListRepository(result: .success(result.toDomain()))
        sut = DefaultUserListUseCase(usersListRepository: mockUsersListRepository)
    }
    // MARK: - Tests
    func testUsersListUseCase_passingValidResponse_getSuccessResponse() throws {
        try givenValidReponse()
        let expections = expectation(description: "Should get success response")
        _ = sut.excute(requestValue: .init(q: "swift", page: 1)) { result in
            switch result {
                case .success(_):
                    expections.fulfill()
                case.failure(_):
                    XCTFail("should not throw error")
            }
        }
        waitForExpectations(timeout: 0.1)
    }
}
