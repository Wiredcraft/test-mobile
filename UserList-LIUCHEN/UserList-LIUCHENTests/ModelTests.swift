//
//  ModelTests.swift
//  UserList-LIUCHENTests
//
//  Created by LC on 2020/6/23.
//  Copyright © 2020 LC. All rights reserved.
//

@testable import UserList_LIUCHEN
import XCTest

class ModelTests: XCTestCase {
    var userModel: UserModel!
    var item: Item!
    var apiManager = APIManager()
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        item = nil
        userModel = nil
        super.tearDown()
    }
    
    func test_conformsTo_Decodable() {
        XCTAssertTrue((userModel as Any) is Codable)
        XCTAssertTrue((item as Any) is Codable)
    }
    
    func test_APIManager_mapJson() throws {
        let bundle = Bundle(for: TestBundleClass.self)
        let url = try XCTUnwrap(bundle.url(forResource: "Data", withExtension: "json"))
        let data = try Data(contentsOf: url, options: .dataReadingMapped)
        userModel = apiManager.mapJson(data: data, model: UserModel.self)
        XCTAssertNotNil(userModel.items?.count)
        item = userModel.items?[0]
        XCTAssertEqual(userModel.total_count, 11076)
        XCTAssertEqual(item.login, "swift")
        
    }
}
private class TestBundleClass { }
