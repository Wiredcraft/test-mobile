//
//  DictionaryExtensionTests.swift
//  GitHub-Users-List-AppTests
//
//  Created by 邹奂霖 on 2022/5/12.
//

import XCTest
@testable import GitHub_Users_List_App
class DictionaryExtensionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testQueryString() throws {
        let dic: [String : Any] = ["q":"swift", "page":1]
        let expectString1 = "q=swift&page=1"
        let expectString2 = "page=1&q=swift"
        XCTAssertTrue(expectString1 == dic.queryString || expectString2 == dic.queryString)
    }
}
