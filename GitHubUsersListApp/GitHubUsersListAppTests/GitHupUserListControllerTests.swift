//
//  GitHupUserListControllerTests.swift
//  GitHubUsersListAppTests
//
//  Created by Joy Cheng on 2022/4/1.
//

import XCTest
import MJRefresh
//import GitHupUserListModel

class GitHupUserListControllerTests: XCTestCase {
    
    private var searchText = ""
    private var pageValue = 1
    
    func configure() {
        pageValue = 1
        searchText = ""
    }

    override func setUpWithError() throws {
        try super.setUpWithError()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testHeadRefresh() {
        configure()
        XCTAssertTrue(pageValue == 1, "headRefresh call failed")
    }

    func testFootRefresh() {
        pageValue += 1
        XCTAssertTrue(pageValue >= 1, "footRefresh call failed")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
