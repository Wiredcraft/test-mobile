//
//  UILabelCountdownTests.swift
//  QRApp
//
//  Created by 顾强 on 16/5/20.
//  Copyright © 2016年 johnny. All rights reserved.
//

import XCTest

@testable import QRApp

class UILabelCountdownTests: XCTestCase {

    let testLabel:UILabel = UILabel()
    let timeInterval:NSTimeInterval = 20
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStartCountingWithTimeInterval() -> Void {
        
        
        testLabel.startCountingWithTimeInterval(timeInterval)
        XCTAssert(testLabel.remainTime == timeInterval)
        
        testLabel.startCountingWithTimeInterval(timeInterval, countClosure: nil)
        XCTAssert(testLabel.remainTime == timeInterval)
        XCTAssertNil(testLabel.countingClosure)
        
        testLabel.startCountingWithTimeInterval(timeInterval) { (remainTime) in
            XCTAssert(remainTime < self.timeInterval)
        }
        XCTAssert(testLabel.remainTime == timeInterval)
    }
    
    func testStartCounting() {

        testLabel.startCountingWithTimeInterval(timeInterval)
        XCTAssert(testLabel.text == "\(Int(timeInterval + 1)) s")
        
    }
    
    func testCancelCounting() {
        
        testLabel.startCountingWithTimeInterval(timeInterval)
        let string = testLabel.text
        testLabel.cancelCounting()
        XCTAssertNil(testLabel.countingClosure)
        XCTAssert(testLabel.text == string)
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
