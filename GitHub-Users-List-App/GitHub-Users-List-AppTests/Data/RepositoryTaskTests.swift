//
//  RepositoryTaskTests.swift
//  GitHub-Users-List-AppTests
//
//  Created by 邹奂霖 on 2022/5/12.
//

import XCTest
@testable import GitHub_Users_List_App
class RepositoryTaskTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCancel_isCancelledIsTrue() throws {
        let task = RepositoryTask()
        task.cancel()
        XCTAssertTrue(task.isCancelled)
    }

}
