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
    
    func testGetSeedAsyncNoCacheHttpOk() {
        let theSeed = "37790a1b728096b4141864f49159ad47"
        let expiredAt = NSDate().timeIntervalSince1970 * 1000
        let data = "{\"seed\":\"\(theSeed)\",\"expiredAt\":\(expiredAt)}".dataUsingEncoding(NSUTF8StringEncoding)
        let seedManager = MockedSeedManager(cachedData: nil, httpData: data)
        let expectation = expectationWithDescription("SeedManager.getSeedAsync should return a seed via the callback")
        seedManager.getSeedAsync { seed in
            XCTAssertNotNil(seed)
            XCTAssertEqual(seed!.seed, theSeed)
            XCTAssertEqual(seed!.expiredAt, Int(expiredAt))
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
        let seedManager = MockedSeedManager(cachedData: nil, httpData: nil)
        let expectation = expectationWithDescription("SeedManager.getSeedAsync should return a seed via the callback")
        seedManager.getSeedAsync { seed in
            XCTAssertNil(seed)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(3) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    
    func testGetSeedAsyncCacheValid() {
        let theSeed = "37790a1b728096b4141864f49159ad47"
        let expiredAt = NSDate().timeIntervalSince1970 * 1000 + 1000
        let data = "{\"seed\":\"\(theSeed)\",\"expiredAt\":\(expiredAt)}".dataUsingEncoding(NSUTF8StringEncoding)
        let seedManager = MockedSeedManager(cachedData: data, httpData: nil)
        let expectation = expectationWithDescription("SeedManager.getSeedAsync should return a seed via the callback")
        seedManager.getSeedAsync { seed in
            XCTAssertNotNil(seed)
            XCTAssertEqual(seed!.seed, theSeed)
            XCTAssertEqual(seed!.expiredAt, Int(expiredAt))
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

    }
    
    func testGetSeedAsyncCacheInvalidHttpFailed() {
        
    }
}