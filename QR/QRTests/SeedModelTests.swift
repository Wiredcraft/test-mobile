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
    func getData(seed:NSString, expiredAt: Int) -> NSData {
        return "{\"seed\":\"\(seed)\",\"expiredAt\":\(expiredAt)}".dataUsingEncoding(NSUTF8StringEncoding)!
    }
    
    func testSeedModelEqual() {
        let seed = "37790a1b728096b4141864f49159ad47"
        let expiredAt = 1469277496963
        let data = getData(seed, expiredAt: expiredAt)
        let model = SeedModel(data: data)
        let model2 = SeedModel(data: data)
        XCTAssertEqual(model, model2)
        
        let model3 = SeedModel(data: getData(seed, expiredAt: expiredAt-1))
        XCTAssertNotEqual(model, model3)
        
        let model4 = SeedModel(data: getData("37790a1b728096b4141864f49159ad48", expiredAt: expiredAt))
        XCTAssertNotEqual(model, model4)
    }
    
    func testSeedModelReturnOkOnValidJsonData() {
        let seed = "37790a1b728096b4141864f49159ad47"
        let expiredAt = 1469277496963
        let model = SeedModel(data: getData(seed, expiredAt: expiredAt))
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.seed, seed)
        XCTAssertEqual(model?.expiredAt, expiredAt)
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
        let expiredAt = Int(expiredDate.timeIntervalSince1970 * 1000)
        let model = SeedModel(data: getData("37790a1b728096b4141864f49159ad47", expiredAt: expiredAt))
        
        let later = NSDate(timeIntervalSinceNow: 1);
        XCTAssertTrue(model!.isExpired(later))
        
        XCTAssertTrue(model!.isExpired(expiredDate))
        
        let early = NSDate(timeIntervalSinceNow: -1)
        XCTAssertFalse(model!.isExpired(early))
    }
}
