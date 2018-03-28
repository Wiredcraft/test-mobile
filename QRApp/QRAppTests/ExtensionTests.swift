//
//  ExtensionTests.swift
//  QRAppTests
//
//  Created by Ville Välimaa on 19/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import XCTest
@testable import QRApp

class ExtensionTests: QRBaseTestCase {
    
    func test_int_extensions() {
        XCTAssertEqual(13.asDouble(), 13.0)
        XCTAssertTrue(type(of: 13.asDouble()) == Double.self)
        XCTAssertTrue(type(of: 13.asCGFloat()) == CGFloat.self)
    }
    
    func test_string_extensions() {
        XCTAssertEqual("%20", " ".urlEncode())
        XCTAssertNotNil("http://www.google.fi".asURL())
        XCTAssertTrue(type(of: "http://www.google.fi".asURL()!) == URL.self)
    }
    
    func test_date() {
        let pastDate = Date.dateFrom(iso8061DateString: "1988-03-19T22:25:01+00:00")
        let futureDate = Date.dateFrom(iso8061DateString: "2030-03-19T22:25:01+00:00")
        
        XCTAssertNotNil(pastDate)
        XCTAssertNotNil(futureDate)
        XCTAssertTrue(pastDate!.hasPassed())
        XCTAssertFalse(futureDate!.hasPassed())
    }
    
    func test_url_response() {
        let response = URLResponse()
        
        XCTAssertEqual(response.getStatusCode(), 0)
    }
    
    func test_array() {
        let arr = [1, 2, 3, 4, 5]
        let modifiedArr = arr.addToBeginning(25)
        
        XCTAssertEqual(modifiedArr[0], 25)
        XCTAssertEqual(arr[0], 1)
        XCTAssertEqual(modifiedArr.count, 6)
        XCTAssertEqual(arr.count, 5)
        XCTAssertTrue(arr.isNotEmpty)
        XCTAssertTrue(modifiedArr.isNotEmpty)
    }
    
    func test_uiimage() {
        let image = UIImage()
        let image2 = image.scaled(width: 300, height: 300)
        let image3 = image.scaled(CGSize(width: 250, height: 250))
        let image4 = UIImage.asQRCodeImageFrom("teksti")!
        let image5 = UIImage.asQRCodeImageFrom("teksti", for: 650)!
        
        XCTAssertNotEqual(image.size.width, 300)
        XCTAssertNotEqual(image.size.height, 300)
        XCTAssertEqual(image2.size.width, 300)
        XCTAssertEqual(image2.size.height, 300)
        XCTAssertEqual(image3.size.width, 250)
        XCTAssertEqual(image3.size.height, 250)
        XCTAssertNotEqual(image4.size.width, 300)
        XCTAssertNotEqual(image4.size.height, 300)
        XCTAssertEqual(image5.size.width, 650)
        XCTAssertEqual(image5.size.height, 650)
    }
    
}
