//
//  SeedManagerTests.swift
//  QR
//
//  Created by Samuel Zhang on 7/23/16.
//  Copyright © 2016 Samuel Zhang. All rights reserved.
//

import XCTest
@testable import QR

class MockedSeedManager : SeedManager {
    var cachedInputModel: SeedModel?
    var httpInputModel: SeedModel?
    var cachedOutputModel: SeedModel?

    init(cachedData: SeedModel?, httpData: SeedModel?) {
        cachedInputModel = cachedData
        httpInputModel = httpData
        super.init()
    }
    override internal func getModelFromCache() -> SeedModel? {
        return cachedInputModel
    }
    override internal func getModelFromServer(callback: (SeedModel?) -> Void) {
        callback(httpInputModel)
    }
    override internal func cacheModel(model: SeedModel) {
        cachedOutputModel = model
    }
}

class SeedManagerTests: XCTestCase {
    func getData(seed:NSString, expiredDate:NSDate) -> SeedModel {
        let expiredAt = expiredDate.timeIntervalSince1970 * 1000
        return SeedModel([
            "seed": seed,
            "expiredAt": expiredAt
        ])!
    }

    func testGetSeedAsyncNoCacheHttpOk() {
        let expectation = expectationWithDescription("getSeedAsync return ok when no cache but http ok")

        let data = getData("37790a1b728096b4141864f49159ad47", expiredDate: NSDate(timeIntervalSinceNow: 60))

        let seedManager = MockedSeedManager(cachedData: nil, httpData: data)
        seedManager.getSeedAsync { seed in
            XCTAssertNotNil(seed)
            XCTAssertEqual(data, seed)
            XCTAssertEqual(seedManager.cachedOutputModel, data)
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(3) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

    func testGetSeedAsyncNoCacheHttpFail() {
        let expectation = expectationWithDescription("getSeedAsync return nil when no cache, http fail")
        let seedManager = MockedSeedManager(cachedData: nil, httpData: nil)
        seedManager.getSeedAsync { seed in
            XCTAssertNil(seed)
            XCTAssertNil(seedManager.cachedOutputModel)
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(3) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

    func testGetSeedAsyncCacheValid() {
        let expectation = expectationWithDescription("getSeedAsync return ok when cache is valid")
        let theSeed = "37790a1b728096b4141864f49159ad47"
        let data = getData(theSeed, expiredDate: NSDate(timeIntervalSinceNow: 60))

        let seedManager = MockedSeedManager(cachedData: data, httpData: nil)
        seedManager.getSeedAsync { seed in
            XCTAssertNotNil(seed)
            XCTAssertEqual(data, seed)
            XCTAssertNil(seedManager.cachedOutputModel)
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(3) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

    func testGetSeedAsyncCacheInvalidHttpOk() {
        let expectation = expectationWithDescription("getSeedAsync return ok when cache invalid http ok")
        let theSeed = "37790a1b728096b4141864f49159ad47"
        let cachedData = getData(theSeed, expiredDate: NSDate(timeIntervalSinceNow: -10))
        let httpData = getData(theSeed, expiredDate: NSDate(timeIntervalSinceNow: 60))

        let seedManager = MockedSeedManager(cachedData: cachedData, httpData: httpData)
        seedManager.getSeedAsync { seed in
            XCTAssertNotNil(seed)
            XCTAssertEqual(httpData, seed)
            XCTAssertEqual(seedManager.cachedOutputModel, httpData)
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(3) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

    func testGetSeedAsyncCacheInvalidHttpFailed() {
        let expectation = expectationWithDescription("getSeedAsync return nil when cache invalid, http failed")
        let theSeed = "37790a1b728096b4141864f49159ad47"
        let cachedData = getData(theSeed, expiredDate: NSDate(timeIntervalSinceNow: -10))

        let seedManager = MockedSeedManager(cachedData: cachedData, httpData: nil)
        seedManager.getSeedAsync { seed in
            XCTAssertNil(seed)
            XCTAssertNil(seedManager.cachedOutputModel)
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(3) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

}
