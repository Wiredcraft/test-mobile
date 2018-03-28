//
//  UtillsTests.swift
//  QRAppTests
//
//  Created by Ville Välimaa on 19/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import XCTest
@testable import QRApp

class UtilsTests: QRBaseTestCase {
    
    func test_with() {
        let label = with(UILabel()) {
            $0.text = "text"
        }
        
        XCTAssertEqual(label.text, "text")
        XCTAssertTrue(type(of: label) == UILabel.self)
    }
}
