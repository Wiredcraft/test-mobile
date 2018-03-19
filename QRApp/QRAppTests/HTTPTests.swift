//
//  HTTPTests.swift
//  QRAppTests
//
//  Created by Ville Välimaa on 19/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import XCTest
@testable import QRApp

class HTTPTests: QRBaseTestCase {
    
    func test_http_task_request() {
        let request = HTTPTask.createRequest(.GET, url: URL(string: "http://www.google.fi")!)
        let request2 = HTTPTask.createRequest(.POST, url: URL(string: "http://www.google.fi")!, body: "abc123")
        
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request2.httpMethod, "POST")
        XCTAssertEqual(request.url?.absoluteString, "http://www.google.fi")
        XCTAssertEqual(request2.url?.absoluteString, "http://www.google.fi")
        XCTAssertEqual(String(data: request2.httpBody!, encoding: .utf8), "abc123")
    }
    
    func test_http_task() {
        let task = HTTPTask(.GET, session: URLSession.shared, url: URL(string: "http://www.google.fi"))
        
        XCTAssertNotNil(task)
    }
    
    // TODO: Implement mock HTTP-class and comprehensive tests.
}
