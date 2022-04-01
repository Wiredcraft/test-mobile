//
//  GitHupUserListDataTests.swift
//  GitHubUsersListAppTests
//
//  Created by Joy Cheng on 2022/4/1.
//

import XCTest
import Alamofire
import SwiftyJSON

class GitHupUserListDataTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testGetListData() {
        callNetworkSource()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            callNetworkSource()
        }
    }
    
    func callNetworkSource() {
        let url = "https://api.github.com/search/users?q=swift&page=1"
        let promise = expectation(description: "sucessed")
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                promise.fulfill()
            case .failure(let error):
                print(error)
                XCTFail("ERROR:\(error.localizedDescription)")
            }
        }
    }

}
