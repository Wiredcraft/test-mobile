//
//  QRLocalSaverTests.swift
//  QRApp
//
//  Created by 顾强 on 16/5/20.
//  Copyright © 2016年 johnny. All rights reserved.
//

import XCTest

@testable import QRApp

class QRLocalSaverTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testReadFromLocal() {
        let string:String! = "aString"
        let date:NSDate = NSDate()
        
        QRLocalSaver.saveToLocal(string, date: date)
        let saver = QRLocalSaver.readFromLocal()
        XCTAssert(saver?.dataString == string && (saver?.ExpiredDate.isEqualToDate(date))!)
    }
    
    func testSaveToLocal() -> Void {
        
        let string:String! = "aString"
        let date:NSDate = NSDate()
        
        QRLocalSaver.saveToLocal(string, date: date)
        var saver = QRLocalSaver.readFromLocal()
        XCTAssert(saver?.dataString == string && (saver?.ExpiredDate.isEqualToDate(date))!)
        
        let anotherString:String! = "anotherString"
        let anotherDate:NSDate = NSDate()
        
        saver?.dataString = anotherString
        saver?.ExpiredDate = anotherDate
        saver?.saveToLocal()
         XCTAssert(saver?.dataString == anotherString && (saver?.ExpiredDate.isEqualToDate(anotherDate))!)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
