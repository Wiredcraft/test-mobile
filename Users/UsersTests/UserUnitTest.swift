//
//  UserUnitTest.swift
//  UsersTests
//
//  Created by ivanzeng on 2021/2/3.
//  Copyright © 2021 none. All rights reserved.
//

import XCTest

class UserUnitTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testDataCodable() throws {
        let test = """
        {
        "login": "swift124123412341nmbvx,bvnwektrb2kq3rbwtwert-203i50234j523452345",
        "id": 50235,
        "node_id": "MDEyOk9yZ2FuaXphdGlvbjUwMjM1",
        "avatar_url": "https://avatars.githubusercontent.com/u/50235?v=4",
        "gravatar_id": "",
        "url": "https://api.github.com/users/swift",
        "html_url": "https://github.com/swift",
        "followers_url": "https://api.github.com/users/swift/followers",
        "following_url": "https://api.github.com/users/swift/following{/other_user}",
        "gists_url": "https://api.github.com/users/swift/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/swift/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/swift/subscriptions",
        "organizations_url": "https://api.github.com/users/swift/orgs",
        "repos_url": "https://api.github.com/users/swift/repos",
        "events_url": "https://api.github.com/users/swift/events{/privacy}",
        "received_events_url": "https://api.github.com/users/swift/received_events",
        "type": "Organization",
        "site_admin": false,
        "score": 1.0
        }
        """
        let result = try? JSONDecoder().decode(GithubUser.self, from: test.data(using: .utf8)!)
        XCTAssertNotNil(result)
        XCTAssertEqual(result!.avatarURL, "https://avatars.githubusercontent.com/u/50235?v=4")
        XCTAssertEqual(result!.login, "swift124123412341nmbvx,bvnwektrb2kq3rbwtwert-203i50234j523452345")
    }

    func testSearchNormal() throws {
        let viewmodel = UserViewModel()
        viewmodel.searchTextDidChange("swift")
        viewmodel.requestDidSuccess = {
            XCTAssertFalse(viewmodel.requestIsExcuting)
        }
        viewmodel.usersDataDidChange = { _ in
            XCTAssertTrue(viewmodel.dataArr.count > 10)
        }
    }

    func testSearchEmpty() throws {
        let viewmodel = UserViewModel()
        viewmodel.searchTextDidChange("swiftvavsa")
        viewmodel.requestDidSuccess = {
            XCTAssertFalse(viewmodel.requestIsExcuting)
        }
        viewmodel.usersDataDidChange = { _ in
            XCTAssertTrue(viewmodel.dataArr.isEmpty)
            XCTAssertNil(viewmodel.errMsg)
        }
    }

    func testSearchFail() throws {
        let viewmodel = UserViewModel()
        viewmodel.searchTextDidChange("swift", pageIndex: 100)
        viewmodel.requestDidSuccess = {
            XCTAssertFalse(viewmodel.requestIsExcuting)
        }
        viewmodel.usersDataDidChange = { _ in
            XCTAssertTrue(viewmodel.dataArr.isEmpty)
            XCTAssertNotNil(viewmodel.errMsg)
        }
    }

    func testApi() throws {

        let query = "swift"
        let pageIndex = 1

        APIClient.shared.getUsers(query: query, page: pageIndex) { result in
            switch result {
            case let .success(response):
                let users = response.result?.items
                XCTAssertNotNil(users)
                XCTAssertTrue(users!.count > 10)
            case .error:
                break
             }
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
