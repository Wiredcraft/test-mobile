//
//  SeedManagerIntegrationTest.swift
//  QR
//
//  Created by Samuel Zhang on 7/31/16.
//  Copyright © 2016 Samuel Zhang. All rights reserved.
//

import XCTest
@testable import QR

class SeedManagerIntegrationTest: XCTestCase {
    
    func testGetSeedAsync() {
        let expectation = expectationWithDescription("getSeedAsync work with server")
        let seedManager = SeedManager.sharedInstance
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
