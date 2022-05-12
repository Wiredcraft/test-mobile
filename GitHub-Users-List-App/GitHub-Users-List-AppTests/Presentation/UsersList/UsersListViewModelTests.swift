//
//  UsersListViewModelTests.swift
//  GitHub-Users-List-AppTests
//
//  Created by 邹奂霖 on 2022/5/5.
//

import XCTest
@testable import GitHub_Users_List_App
class UsersListViewModelTests: XCTestCase {
    // MARK: -  instance property
    var sut: UsersListViewModel!

    // MARK: - TestCase LifeCycle
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    // MARK: - Given
    func givenFirstPageResponse() throws -> UsersListPage {
        let decoder = JSONDecoder()
        let validData = try Data.fromJSON(fileName: "UsersListResponse")
        let result = try decoder.decode(UsersListResponseDTO.self, from: validData)
        return result.toDomain()
    }


    // MARK: - Tests
    func testViewModel_whenViewDidLoad_viewModelLoadingIsRefresh() {
        let mockUseCase = MockUsersListUseCase()
        let viewModel = UsersListViewModel(usecase: mockUseCase)
        viewModel.inputs.viewDidLoad()
        XCTAssertEqual(viewModel.outputs.loading.value, .refresh)
    }

    func test_whenViewDidLoad_viewModelRequestFirstPage() throws {
        let mockUseCase = MockUsersListUseCase()
        mockUseCase.expectation = self.expectation(description: "should load first page")
        let firstPageResponse = try givenFirstPageResponse()
        mockUseCase.page = firstPageResponse
        sut = UsersListViewModel(usecase: mockUseCase)
        sut.refreshPage()
        waitForExpectations(timeout: 0.1)
        XCTAssertEqual(sut.currentPage, 1)
        XCTAssertEqual(sut.pages.count, 1)
        XCTAssertEqual(sut.pages.first, firstPageResponse)
        XCTAssertEqual(sut.totalPageCount, firstPageResponse.totalCount / 30)
        XCTAssertEqual(sut.nextPage, 2)
    }

    func testLoadPage_whenResponseHasMoreData_hasMoreDataIsTrue() throws {
        let mockUseCase = MockUsersListUseCase()
        mockUseCase.expectation = self.expectation(description: "should load first page")
        let firstPageResponse = try givenFirstPageResponse()
        mockUseCase.page = firstPageResponse
        sut = UsersListViewModel(usecase: mockUseCase)
        sut.refreshPage()

        sut.inputs.viewDidLoad()
        waitForExpectations(timeout: 0.1)
        XCTAssertTrue(sut.hasMorePage)
    }

    func testLoadPage_whenReceiveValidResponse_triggerError() {
        let mockUseCase = MockUsersListUseCase()
        let loadPageErrorExpectation = expectation(description: "should call error")
        mockUseCase.error = NSError(domain: "com.GitHub-UsersList-App", code: 123)
        let sut = UsersListViewModel(usecase: mockUseCase)
        sut.refreshPage()
        sut.outputs.loadPageError.observe(on: self) { error in
            if let _ = error {
                loadPageErrorExpectation.fulfill()
            }
        }

        sut.inputs.viewDidLoad()
        waitForExpectations(timeout: 0.1)
    }
}
