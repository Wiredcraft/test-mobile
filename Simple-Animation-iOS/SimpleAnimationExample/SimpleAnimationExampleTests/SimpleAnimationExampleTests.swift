//
//  SimpleAnimationExampleTests.swift
//  SimpleAnimationExampleTests
//
//  Created by ShuRong Deng on 07/07/2017.
//  Copyright © 2017 ShuRong Deng. All rights reserved.
//

import XCTest
import CoreMotion
@testable import SimpleAnimationExample

class SimpleAnimationExampleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        let motionManager = CMMotionManager()
        let isAccelerometerAvailable = motionManager.isAccelerometerAvailable
        XCTAssertTrue(isAccelerometerAvailable, "The simulator does not simulate any motion. You have to use a physical device to test anything with CMMotionManager.")

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
