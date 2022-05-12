//
//  GitHub_Users_List_AppUITests.swift
//  GitHub-Users-List-AppUITests
//
//  Created by 邹奂霖 on 2022/5/5.
//

import XCTest
@testable import GitHub_Users_List_App
class GitHub_Users_List_AppUITests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
        XCUIApplication().launch()
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOpenUserDetail() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        XCTAssertTrue(app.otherElements[AccessibilityIdentifier.userDetailViewController].waitForExistence(timeout: 5))
    }
}
