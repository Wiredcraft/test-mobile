//
//  ModelTests.swift
//  QRAppTests
//
//  Created by Ville Välimaa on 19/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import XCTest
@testable import QRApp

class ModelTests: QRBaseTestCase {
    
    func test_AppError_Unknown() {
        let error = AppError.makeUnknownError()
        
        XCTAssertNotNil(error)
        XCTAssertEqual("Unknown error occured!", error.errorDescription)
        XCTAssertNil(error.httpStatusCode)
    }
    
    func test_AppError_HTTP() {
        let error = AppError.makeHTTPError(httpStatusCode: 404)
        
        XCTAssertNotNil(error)
        XCTAssertEqual("Could not complete network request!", error.errorDescription)
        XCTAssertEqual(error.httpStatusCode, 404)
    }
    
    func test_AppError_Custom() {
        let error = AppError.makeCustomError("just error")
        
        XCTAssertNotNil(error)
        XCTAssertEqual("just error", error.errorDescription)
        XCTAssertNil(error.httpStatusCode)
    }
    
    func test_QRCaptureSession() {
        let view = UIView()
        let session = QRCaptureSession(targetView: view)
        
        XCTAssertNotNil(session)
        XCTAssertFalse(session!.isRunning)
    }
    
    func test_baseDictModel() {
        let dict = [
            "key1": 54,
            "key2": "text",
            "key3": true
            ] as [String : Any]
        
        let baseDict = BaseDictModel(dict)
        
        XCTAssertEqual(baseDict.intOrZero("key1"), 54)
        XCTAssertEqual(baseDict.stringOrEmpty("key2"), "text")
        XCTAssertTrue(baseDict.boolOrFalse("key3"))
        XCTAssertEqual(baseDict.intOrZero("key4"), 0)
        XCTAssertEqual(baseDict.stringOrEmpty("key5"), "")
        XCTAssertFalse(baseDict.boolOrFalse("key6"))
    }
    
    func test_qr_code_from_string() {
        let qr = QRCode(text: "hello")
        let image = qr?.asUIImage()
        let image2 = qr?.asUIImageScaledTo(size: 300)
        let wcImage = qr?.asWiredCraftQRImage(size: 300)
        let text = qr?.toString()
        
        XCTAssertNotNil(qr)
        XCTAssertNotNil(image)
        XCTAssertNotNil(image2)
        XCTAssertNotNil(wcImage)
        XCTAssertEqual(text, "hello")
    }
    
    func test_qr_code_from_data() {
        let data = Data()
        let qr = QRCode(data: data)
        let image = qr?.asUIImage()
        let image2 = qr?.asUIImageScaledTo(size: 300)
        let wcImage = qr?.asWiredCraftQRImage(size: 300)
        let text = qr?.toString()
        
        XCTAssertNotNil(qr)
        XCTAssertNotNil(image)
        XCTAssertNotNil(image2)
        XCTAssertNotNil(wcImage)
        XCTAssertNil(text)
    }
    
    func text_qr_membership() {
        let membership = QRMembership(seed: "seed", expires_at: "time")
        
        XCTAssertEqual(membership.seed, "seed")
        XCTAssertEqual(membership.expires_at, "time")
    }
}
