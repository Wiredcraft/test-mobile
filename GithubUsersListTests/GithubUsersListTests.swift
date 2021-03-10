//
//  GithubUsersListTests.swift
//  GithubUsersListTests
//
//  Created by 裘诚翔 on 2021/3/6.
//

import XCTest
import RxSwift
import RxRelay
@testable import GithubUsersList

class GithubUsersListTests: XCTestCase {
    
    let disposeBag = DisposeBag()

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
    
    func testUsersListForSearch() {
        let viewModel = GULUsersListViewModel()
        let search = BehaviorRelay<String>(value: "")
        let header = PublishRelay<Void>()
        let footer = PublishRelay<Void>()
        let input = GULUsersListViewModel.GULUsersListInput(search: search, headerRefresh: header, footerRefresh: footer)
        
        let output = viewModel.transform(input: input)
        
        
        let expext = expectation(description: "search")
        
        output.usersItems.skip(1).subscribe { (list) in
            expext.fulfill()
        }.disposed(by: disposeBag)
        
        XCTAssert(output.usersItems.value.count == 0, "shouldn't have users data")
        input.search.accept("swift")
        waitForExpectations(timeout: 30) { (error) in
            guard error == nil else {
                XCTFail(error!.localizedDescription)
                return
            }
            XCTAssert(viewModel.currentPage == 1, "the page of search action is wrong")
            XCTAssert(output.usersItems.value.count > 0, "no users data")
            output.usersItems.value.forEach { (vm) in
                XCTAssert(vm.name.value?.isEmpty == false, "no user's name")
                XCTAssert(vm.htmlUrl.value?.isEmpty == false, "no user's htmlUrl")
                XCTAssert(vm.icon.value?.isEmpty == false, "no user's icon")
                XCTAssertNotNil(vm.score.value, "no user's score")
            }
        }
    }
    
    
    func testUsersListForHeader() {
        let viewModel = GULUsersListViewModel()
        let search = BehaviorRelay<String>(value: "sss")
        let header = PublishRelay<Void>()
        let footer = PublishRelay<Void>()
        let input = GULUsersListViewModel.GULUsersListInput(search: search, headerRefresh: header, footerRefresh: footer)
        
        let output = viewModel.transform(input: input)
        
        
        let expext = expectation(description: "header")
        
        output.usersItems.skip(1).subscribe { (list) in
            expext.fulfill()
        }.disposed(by: disposeBag)
        
        XCTAssert(output.usersItems.value.count == 0, "shouldn't have users data")
        input.headerRefresh.accept(())
        waitForExpectations(timeout: 30) { (error) in
            guard error == nil else {
                XCTFail(error!.localizedDescription)
                return
            }
            XCTAssert(viewModel.currentPage == 1, "the page of header action is wrong")
            XCTAssert(output.usersItems.value.count > 0, "no users data")
            output.usersItems.value.forEach { (vm) in
                XCTAssert(vm.name.value?.isEmpty == false, "no user's name")
                XCTAssert(vm.htmlUrl.value?.isEmpty == false, "no user's htmlUrl")
                XCTAssert(vm.icon.value?.isEmpty == false, "no user's icon")
                XCTAssertNotNil(vm.score.value, "no user's score")
            }
        }
    }
    
    
    func testUsersListForFooter() {
        let viewModel = GULUsersListViewModel()
        let search = BehaviorRelay<String>(value: "sss")
        let header = PublishRelay<Void>()
        let footer = PublishRelay<Void>()
        let input = GULUsersListViewModel.GULUsersListInput(search: search, headerRefresh: header, footerRefresh: footer)
        
        let output = viewModel.transform(input: input)
        
        
        let expext = expectation(description: "footer")
        
        output.usersItems.skip(1).subscribe { (list) in
            expext.fulfill()
        }.disposed(by: disposeBag)
        
        XCTAssert(output.usersItems.value.count == 0, "shouldn't have users data")
        input.footerRefresh.accept(())
        waitForExpectations(timeout: 30) { (error) in
            guard error == nil else {
                XCTFail(error!.localizedDescription)
                return
            }
            XCTAssert(viewModel.currentPage > 1, "the page of footer action is wrong")
            XCTAssert(output.usersItems.value.count > 0, "no users data")
            output.usersItems.value.forEach { (vm) in
                XCTAssert(vm.name.value?.isEmpty == false, "no user's name")
                XCTAssert(vm.htmlUrl.value?.isEmpty == false, "no user's htmlUrl")
                XCTAssert(vm.icon.value?.isEmpty == false, "no user's icon")
                XCTAssertNotNil(vm.score.value, "no user's score")
            }
        }
    }
}
