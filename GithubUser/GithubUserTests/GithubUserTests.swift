//
//  GithubUserTests.swift
//  GithubUserTests
//
//  Created by zhaitong on 2022/3/25.
//

import XCTest
@testable import GithubUser

class GithubUserTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testSearchUserList() throws {
        let networkExpection = expectation(description: "networkDownSuccess")
        ApiService.getList(keyWord:"swift", page: 1) { resp in
            XCTAssertNotNil(resp)
            networkExpection.fulfill()
            switch(resp){
            case .Success(let data):
                print(data.debugDescription)
                break
            case .Error(_, let msg):
                print(msg)
                break
            }
        }
        let result = XCTWaiter(delegate: self).wait(for: [networkExpection], timeout: 30)
        if result == .timedOut {
            print("Request timeout")
        }
    }
    func testReposList() throws {
        let networkExpection = expectation(description: "networkDownSuccess")
        ApiService.getList(keyWord:"swift", page: 1) { resp in
            XCTAssertNotNil(resp)
            networkExpection.fulfill()
            switch(resp){
            case .Success(let data):
                print(data.debugDescription)
                break
            case .Error(_, let msg):
                print(msg)
                break
            }
        }
        let result = XCTWaiter(delegate: self).wait(for: [networkExpection], timeout: 30)
        if result == .timedOut {
            print("Request timeout")
        }
    }
}
