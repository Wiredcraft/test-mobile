//
//  WiredcraftUITests.swift
//  WiredcraftUITests
//
//  Created by codeLocker on 2020/6/10.
//  Copyright © 2020 codeLocker. All rights reserved.
//

import XCTest

class WiredcraftUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        let app = XCUIApplication()
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// test clear input content
    func testQueryInputClearTest() {
        let app = XCUIApplication()
        let querySearchField = app.otherElements["com.wiredcraft.element.home.searchBar"].searchFields["please input here to search"]
        querySearchField.tap()
        querySearchField.buttons["Clear text"].tap()

        let tableViews = app/*@START_MENU_TOKEN@*/.tables["com.wiredcraft.element.home.tableView"]/*[[".tables[\"Pull down to refresh, Last updated: Today 11:32, Tap or pull up to load more\"]",".tables[\"com.wiredcraft.element.home.tableView\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        tableViews.swipeUp()
    }
    
    /// test swipe down to refresh
    func testSwipeDownRefresh() {
        let app = XCUIApplication()
        let tableView = app.tables["com.wiredcraft.element.home.tableView"]
        tableView.swipeDown()
        tableView/*@START_MENU_TOKEN@*/.staticTexts["https://github.com/swift"]/*[[".cells.matching(identifier: \"com.wiredcraft.element.user.cell\").staticTexts[\"https:\/\/github.com\/swift\"]",".staticTexts[\"https:\/\/github.com\/swift\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Wiredcraft.WCDetailView"].buttons["Back"].tap()
    }
    
    /// test swipe up to load more
    func testSwipeUpLoadMore() {
        let app = XCUIApplication()
        let tableView = app.tables["com.wiredcraft.element.home.tableView"]
        for _ in 0 ..< 10 {
            tableView.swipeUp()
        }
        tableView/*@START_MENU_TOKEN@*/.staticTexts["https://github.com/swift"]/*[[".cells.matching(identifier: \"com.wiredcraft.element.user.cell\").staticTexts[\"https:\/\/github.com\/swift\"]",".staticTexts[\"https:\/\/github.com\/swift\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Wiredcraft.WCDetailView"].buttons["Back"].tap()
    }
}
