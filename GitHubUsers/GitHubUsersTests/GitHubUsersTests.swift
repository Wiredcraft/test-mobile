//
//  GitHubUsersTests.swift
//  GitHubUsersTests
//
//  Created by lusheng tan on 2019/4/10.
//  Copyright © 2019 lusheng tan. All rights reserved.
//

import XCTest
@testable import GitHubUsers

class GitHubUsersTests: XCTestCase {
    var homeViewModel: HomeViewModel!
    var searchUsersViewModel: SearchUsersViewModel!
    override func setUp() {
        homeViewModel = HomeViewModel()
        searchUsersViewModel = SearchUsersViewModel()
    }
    func testSwiftUser() {
        homeViewModel.page.accept(1)
        _ = homeViewModel.result.subscribe(onNext: { result in
            switch result {
            case .success(let homeResult):
                XCTAssertNil(homeResult)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        })
    }
    func testSearchUser() {
        searchUsersViewModel.keyWord.onNext("oc")
        _ = searchUsersViewModel.result.subscribe(onNext: { result in
            switch result {
            case .success(let homeResult):
                XCTAssertNil(homeResult)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        })
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
