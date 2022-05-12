//
//  UserDetailViewModelTests.swift
//  GitHub-Users-List-AppTests
//
//  Created by 邹奂霖 on 2022/5/12.
//

import XCTest
@testable import GitHub_Users_List_App
class UserDetailViewModelTests: XCTestCase {
    var sut: UserDetailViewModel!
    // MARK: - TestCase LifeCycle
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    // MARK: - Given
    func givenResponse() throws -> [UserRepo] {
        let decoder = JSONDecoder()
        let validData = try Data.fromJSON(fileName: "UserRepoResponse")
        let result = try decoder.decode([UserRepoResponseDTO].self, from: validData)
        return result.map { $0.toDomain() }
    }

    func test_whenViewDidLoad_Load() throws {
        let mockUseCase = MockUserDetailUseCase()
        mockUseCase.expectation = self.expectation(description: "should load first page")
        let firstPageResponse = try givenResponse()
        mockUseCase.repos = firstPageResponse
        sut = UserDetailViewModel(user: User(avatarUrl: "", htmlUrl: "", id: 0, login: "swift", score: 0), usecase: mockUseCase)
        sut.viewDidLoad()
        waitForExpectations(timeout: 0.1)

        XCTAssertEqual(sut.repoViewModels.value.count, firstPageResponse.count)
    }
}
