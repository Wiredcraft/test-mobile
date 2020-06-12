//
//  WiredcraftTests.swift
//  WiredcraftTests
//
//  Created by codeLocker on 2020/6/10.
//  Copyright © 2020 codeLocker. All rights reserved.
//

import XCTest
import RxCocoa
import RxSwift
import MJRefresh
@testable import Wiredcraft

class WiredcraftTests: XCTestCase {

    fileprivate lazy var disposeBag = DisposeBag()
    fileprivate lazy var timeout = 30 as TimeInterval // timeout
    
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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    /// expect the result of query network is success
    /// - Parameters:
    ///   - query: keywordd
    ///   - page: page number
    func fetchUsersList_successResponse(query: String, page: Int) {
        let expectationStr = expectation(description:"com.wiredcraft.unit.test.query")
        let _ = WCHomeNetworkService.usersList(query: query, page: page).subscribe(onNext: { (response) in
            expectationStr.fulfill()
            if let _ = response.errors {
                XCTAssertFalse(true)
                return
            }
            XCTAssertFalse((response.items?.count ?? 0) == 0)
            
        }, onError: { (error) in
            XCTAssertFalse(true, error.localizedDescription)
            
        }, onCompleted: nil, onDisposed: nil)
        waitForExpectations(timeout: self.timeout, handler:nil)
    }
    
    /// expect the result of query network is failure
    /// - Parameters:
    ///   - query: keywordd
    ///   - page: page number
    func fetchUsersList_failureResponse(query: String, page: Int) {
        let expectationStr = expectation(description:"com.wiredcraft.unit.test.query")
        let _ = WCHomeNetworkService.usersList(query: "", page: 1).subscribe(onNext: { (response) in
            expectationStr.fulfill()
            // query empty keyword should be error
            if let _ = response.errors {
                XCTAssertFalse(false)
                return
            }
            XCTAssertNil(response.items)
            
        }, onError: { (error) in
            XCTAssertFalse(true, error.localizedDescription)
            
        }, onCompleted: nil, onDisposed: nil)
        waitForExpectations(timeout: self.timeout, handler:nil)
    }
    
    /// query user list with keyword 'swift', the network should be success and response item count > 0
    func testFetchUsersList_withQuerySwift_successResponse() {
        self.fetchUsersList_successResponse(query: "swift", page: 1)
    }
    
    /// query user list with keyword 'swift' for page 2, the network should be success and response item count > 0
    func testFetchUsersList_withQuerySwiftNextPage_successResponse() {
        self.fetchUsersList_successResponse(query: "swift", page: 2)
    }
    
    /// query user list with empty keyword, the network should be fail and response item should be nil
    func testFetchUsersList_withQueryEmpty_failureResponse() {
        self.fetchUsersList_failureResponse(query: "", page: 1)
    }
    
    /// execute the HomeViemModel search action can work and get success reponse
    func testHomeViewModel_queryAction_successResponse() {
        let expectationStr = expectation(description:"com.wiredcraft.unit.test.queryAction")
        
        let viewModel = WCHomeViewModel()
        let querySearchAction = PublishSubject<String>()
        viewModel.querySearchAction = querySearchAction
        querySearchAction.onNext("swift")
        /// skip the users Observable create signal
        let _ = viewModel.users.skip(1).subscribe(onNext: { (userModels) in
            expectationStr.fulfill()
            XCTAssertFalse(userModels.count == 0)
            
        }, onError: { (error) in
            XCTAssertFalse(true)
            
        }, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
        waitForExpectations(timeout: self.timeout, handler:nil)
    }
    
    /// if the userModel has correct value 
    func testHomeViewModel_userModel_hasCorrectValue() {
        let expectationStr = expectation(description:"com.wiredcraft.unit.test.queryAction")
        
        let viewModel = WCHomeViewModel()
        let querySearchAction = PublishSubject<String>()
        viewModel.querySearchAction = querySearchAction
        querySearchAction.onNext("swift")
        /// skip the users Observable create signal
        let _ = viewModel.users.skip(1).subscribe(onNext: { (userModels) in
            expectationStr.fulfill()
            if userModels.count == 0 {
                XCTAssertFalse(true)
                return
            }
            guard let userModel = userModels.first else {
                XCTAssertFalse(true)
                return
            }
            guard let nickname = userModel.login, !nickname.isEmpty else {
                XCTAssertFalse(true)
                return
            }
            guard let avatarUrl = userModel.avatar_url, !avatarUrl.isEmpty, avatarUrl.hasPrefix("https://") else {
                XCTAssertFalse(true)
                return
            }
            guard let _ = userModel.score else {
                XCTAssertFalse(true)
                return
            }
            guard let homepage = userModel.html_url, !homepage.isEmpty, homepage.hasPrefix("https://") else {
                XCTAssertFalse(true)
                return
            }
            
        }, onError: { (error) in
            XCTAssertFalse(true)
            
        }, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
        waitForExpectations(timeout: self.timeout, handler:nil)
    }
}

