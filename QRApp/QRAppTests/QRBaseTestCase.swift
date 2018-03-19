//
//  QRBaseTestCase.swift
//  QRAppTests
//
//  Created by Ville Välimaa on 19/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import XCTest

class QRBaseTestCase: XCTestCase {
    
    /// Allows waiting for result with condition continuously re-evaluated.
    ///
    internal func waitForTimeoutWithCondition(_ timeout: TimeInterval, condition: @autoclosure () -> Bool) {
        let startDate = Date()
        while(condition() == false && Date().timeIntervalSince(startDate) < timeout) {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
        }
    }
}
