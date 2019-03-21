//
//  QRCodeToolTests.swift
//  QRCodeToolTests
//
//  Created by 彭柯柱 on 2019/3/16.
//  Copyright © 2019 彭柯柱. All rights reserved.
//

import XCTest
@testable import QRCodeTool

class QRCodeToolTests: XCTestCase {
    let apiGetSeed: QTApiGetSeed = QTApiGetSeed()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let exception: XCTestExpectation = self.expectation(description: "Time out")
        self.apiGetSeed.getRandomSeed({ (result) in
            print("json: " + "\((result!.responseData)!)")
            print("seed: " + "\((result?.seed)!)")
            exception.fulfill()
        }) { (error) in
            print("error: " + "\((error?.message)!)")
            exception.fulfill()
        }
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

