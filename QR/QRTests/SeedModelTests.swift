//
//  SeedModelTests.swift
//  QR
//
//  Created by Samuel Zhang on 7/23/16.
//  Copyright © 2016 Samuel Zhang. All rights reserved.
//

import XCTest
@testable import QR

class SeedModelTests: XCTestCase {
    func testSeedModelReturnOkOnValidJsonData() {
        let validJson = "{\"seed\":\"37790a1b728096b4141864f49159ad47\",\"expiredAt\":1469277496963}"
        let model = SeedModel(data: validJson.dataUsingEncoding(NSUTF8StringEncoding))
        XCTAssertNotNil(model)
    }
    
    func testSeedModelReturnNilOnNilData() {
        let model = SeedModel(data: nil)
        XCTAssertNil(model)
    }
    
    func testSeedModelReturnNilOnInvalidJsonData() {
        let model = SeedModel(data: "{\"seed\":".dataUsingEncoding(NSUTF8StringEncoding))
        XCTAssertNil(model)
    }
    
    func testIsExpired() {
        let expiredDate = NSDate()
        let expiredAt = expiredDate.timeIntervalSince1970 * 1000
        let validJson = "{\"seed\":\"37790a1b728096b4141864f49159ad47\",\"expiredAt\":\(expiredAt)}"
        let model = SeedModel(data: validJson.dataUsingEncoding(NSUTF8StringEncoding))
        XCTAssertTrue(model!.isExpired())
        
        XCTAssertTrue(model!.isExpired(expiredDate))
        
        let now = NSDate(timeIntervalSinceNow: -1)
        XCTAssertFalse(model!.isExpired(now))
    }
}
