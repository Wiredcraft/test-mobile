//
//  GithubUsesTests.swift
//  GithubUsesTests
//
//  Created by Apple on 2020/7/20.
//

import XCTest

@testable import GithubUses

class GithubUsesTests: XCTestCase {

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
    
    func testUserDecode() {
        guard let jsonStringURL = Bundle.main.url(forResource: "users", withExtension: "json") else {
            XCTAssert(false, "loadFileFailed")
            return
        }
        guard let userData = try? Data.init(contentsOf: jsonStringURL) else {
            fatalError("load fail")
        }
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode(GithubSearchResult.self, from: userData)
            XCTAssert(result.items.count == 30, "parse error")
        } catch {
            print(error)
        }

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
