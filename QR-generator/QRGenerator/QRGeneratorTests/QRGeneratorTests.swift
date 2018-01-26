//
//  QRGeneratorTests.swift
//  QRGeneratorTests
//
//  Created by tripleCC on 2018/1/22.
//  Copyright © 2018年 tripleCC. All rights reserved.
//

import XCTest
@testable import QRGenerator

class QRGeneratorTests: XCTestCase {
    
    struct QRGeneratorTestsConst {
        static let qrcode: String = "123456789"
        static let expiresAt: String = "2018-01-24T15:37:46+08:00"
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSeedArchivable() {
        var seed = Seed()
        seed.expiresAt = QRGeneratorTestsConst.expiresAt
        seed.seed = QRGeneratorTestsConst.qrcode
        let json = seed.archive()
        XCTAssertEqual(json["seed"] as? String, seed.seed)
        XCTAssertEqual(json["expiresAt"] as? String, seed.expiresAt)
        
        let unarchivedSeed = Seed(unarchive: ["seed" : QRGeneratorTestsConst.qrcode,
                                               "expiresAt" : QRGeneratorTestsConst.expiresAt])
        XCTAssertNotNil(unarchivedSeed)
        XCTAssertEqual(QRGeneratorTestsConst.qrcode, unarchivedSeed.seed)
        XCTAssertEqual(QRGeneratorTestsConst.expiresAt, unarchivedSeed.expiresAt)
        
        seed.archiveToDisk()
        let unarchivedDiskSeed = Seed.unarchiveFromDisk()
        XCTAssertNotNil(unarchivedDiskSeed)
        XCTAssertEqual(seed.seed, unarchivedDiskSeed?.seed)
        XCTAssertEqual(seed.expiresAt, unarchivedDiskSeed?.expiresAt)
    }
    
    func testSeedAPI() {
        
    }
    
    func testQRCodeGenerator() {
        var image = QRCodeGenerator(string: QRGeneratorTestsConst.qrcode).generate()
        XCTAssertNotNil(image)
        XCTAssertTrue(QRGeneratorTestsConst.qrcode == QRCodeReader(image: image!).read())
        
        let imageData = QRGeneratorTestsConst.qrcode.data(using: .isoLatin1, allowLossyConversion: false)!
        image = QRCodeGenerator(data: imageData).generate()
        XCTAssertNotNil(image)
        XCTAssertTrue(QRGeneratorTestsConst.qrcode == QRCodeReader(image: image!).read())
    }
}
