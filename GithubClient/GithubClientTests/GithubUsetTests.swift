//
//  GithubUsetTests.swift
//  GithubClientTests
//
//  Created by Apple on 2020/7/22.
//  Copyright © 2020 Pszertlek. All rights reserved.
//

import XCTest
import Moya
import RxSwift

class GithubUsetTests: XCTestCase {

    
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
    
    func testUserDecode() throws {
        let url = Bundle.main.url(forResource: "users", withExtension: "json")
        XCTAssertNotNil(url)
        let data = try? Data(contentsOf: url!)
        XCTAssertNotNil(data)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let result = try? decoder.decode(GithubSearchResult.self, from: data!) else {
            XCTAssertNotNil(nil,"result nil")
            return
        }
        XCTAssert(result.totalCount == 11287 && result.items.count == 30 && result.incompleteResults == false, "parse fail")
    }

}
