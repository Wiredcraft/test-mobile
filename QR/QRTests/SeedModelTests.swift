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
    let seed = "37790a1b728096b4141864f49159ad47"

    func getData(seed:String, expiredAt:NSDate) -> [String:AnyObject] {
        return [
            "seed": seed,
            "expiredAt":expiredAt.timeIntervalSince1970 * 1000
        ]
    }

    func testSeedModelEqual() {
        let now = NSDate()
        let data = getData(seed, expiredAt: now)
        let model = SeedModel(data)
        let model2 = SeedModel(data)
        XCTAssertEqual(model, model2)

        let model3 = SeedModel(getData(seed, expiredAt:NSDate(timeIntervalSinceNow: -1)))
        XCTAssertNotEqual(model, model3)

        let seed2 = "37790a1b728096b4141864f49159ad48"
        let model4 = SeedModel(getData(seed2, expiredAt: now))
        XCTAssertNotEqual(model, model4)
    }

    func testSeedModelReturnOkOnValidJsonData() {
        let expiredAt = NSDate()
        let model = SeedModel(getData(seed, expiredAt: expiredAt))
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.seed, seed)
        XCTAssertEqual(model?.expiredAt, Int(expiredAt.timeIntervalSince1970 * 1000))
    }

    func testSeedModelReturnNilOnNilData() {
        let model = SeedModel(nil)
        XCTAssertNil(model)
    }

    func testSeedModelReturnNilOnInvalidJsonData() {
        let json = ["seed": seed]
        let model = SeedModel(json)
        XCTAssertNil(model)
    }

    func testSeedModelExpireTimeout() {
        let now = NSDate()
        let diff = 2.0
        let expiredAt = NSDate(timeInterval: diff, sinceDate: now)
        let model = SeedModel(getData(seed, expiredAt: expiredAt))
        XCTAssertEqualWithAccuracy(model!.expireTimeout(), diff, accuracy: 1.0)
    }

    func testSeedModelJson() {
        let model = SeedModel(getData(seed, expiredAt: NSDate()))
        let model2 = SeedModel(model?.json())
        XCTAssertEqual(model, model2)
    }
}
