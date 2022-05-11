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
    var sut: UsersListViewModelType!

    // MARK: - TestCase LifeCycle
    override func setUpWithError() throws {
        try super.setUpWithError()
//        sut = UsersListViewModel(with: UsersListViewModelActions(showUserDetail: {_ in
//
//        }), usecase: useuseca)

    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    // MARK: - Test Protocol Conformance
    func test_viewModel_conformsToUsersListViewModelType() {
        XCTAssertTrue((sut as AnyObject) is UsersListViewModelType)
    }

    func test_viewModel_conformsToUsersListViewModelInputs() {
        XCTAssertTrue((sut as AnyObject) is UsersListViewModelInputs)
    }

    func test_viewModel_conformsToUsersListViewModelOutputs() {
        XCTAssertTrue((sut as AnyObject) is UsersListViewModelOutputs)
    }
    // MARK: - Test inputs

    // MARK: - Test outputs
}
