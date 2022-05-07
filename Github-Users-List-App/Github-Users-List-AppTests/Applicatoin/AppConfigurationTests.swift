//
//  AppConfigurationTests.swift
//  GitHub-Users-List-AppTests
//
//  Created by 邹奂霖 on 2022/5/7.
//

import XCTest
@testable import GitHub_Users_List_App
class AppConfigurationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBaseURL_sameAsConfigure() {
        let appConfig = AppConfiguration()
        let expectedBaseURL = "https://api.github.com"
        XCTAssertEqual(appConfig.apiBaseURL, expectedBaseURL)
    }

}
