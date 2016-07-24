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
    var cachedInputData: NSData?
    var httpInputData: NSData?
    var cachedData: NSData?
    
    init(cachedData: NSData?, httpData: NSData?) {
        cachedInputData = cachedData
        httpInputData = httpData
        super.init()
    }
    override internal func getDataFromCache() -> NSData? {
        return cachedInputData
    }
    override internal func getDataFromServer(callback: (NSData?) -> Void) {
        callback(httpInputData)
    }
    override internal func cacheData(data: NSData) {
        print("cache data \(data)")
        cachedData = data
    }
}

class SeedManagerTests: XCTestCase {
    func getData(seed:NSString, expiredDate:NSDate) -> NSData {
        let expiredAt = expiredDate.timeIntervalSince1970 * 1000
        return "{\"seed\":\"\(seed)\",\"expiredAt\":\(expiredAt)}".dataUsingEncoding(NSUTF8StringEncoding)!
    }
    
    func testGetSeedAsyncNoCacheHttpOk() {
        let expectation = expectationWithDescription("getSeedAsync return ok when no cache but http ok")

        let data = getData("37790a1b728096b4141864f49159ad47", expiredDate: NSDate(timeIntervalSinceNow: 60))
        let expectedModel = SeedModel(data: data)
        
        let seedManager = MockedSeedManager(cachedData: nil, httpData: data)
        seedManager.getSeedAsync { seed in
            XCTAssertNotNil(seed)
            XCTAssertEqual(expectedModel, seed)
            XCTAssertEqual(seedManager.cachedData, data)
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
            XCTAssertNil(seedManager.cachedData)
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
        let expectedModel = SeedModel(data: data)
        
        let seedManager = MockedSeedManager(cachedData: data, httpData: nil)
        seedManager.getSeedAsync { seed in
            XCTAssertNotNil(seed)
            XCTAssertEqual(expectedModel, seed)
            XCTAssertNil(seedManager.cachedData)
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
        let expectedModel = SeedModel(data: httpData)
        
        let seedManager = MockedSeedManager(cachedData: cachedData, httpData: httpData)
        seedManager.getSeedAsync { seed in
            XCTAssertNotNil(seed)
            XCTAssertEqual(expectedModel, seed)
            XCTAssertEqual(seedManager.cachedData, httpData)
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
            XCTAssertNil(seedManager.cachedData)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(3) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testGetSeedAsync() {
        let expectation = expectationWithDescription("getSeedAsync work with server")
        let seedManager = SeedManager()
        seedManager.getSeedAsync { seed in
            XCTAssertNotNil(seed)
            XCTAssertEqual(seed!.seed.length, 32)
            XCTAssert(seed!.expireTimeout() > 0)
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(3) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
}