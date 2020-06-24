//
//  NetworkTests.swift
//  UserList-LIUCHENTests
//
//  Created by LC on 2020/6/23.
//  Copyright © 2020 LC. All rights reserved.
//
@testable import UserList_LIUCHEN
import XCTest

class NetworkTests: XCTestCase {

    var apiManager: APIManager!
    var imageView: UIImageView!
    override func setUp() {
        super.setUp()
        apiManager = APIManager()
        imageView = UIImageView()
        
    }
    override func tearDown() {
        apiManager = nil
        imageView = nil
        super.tearDown()
    }
    func test_baseUrl() {
        XCTAssertEqual(apiManager.userListBaseURL, "https://api.github.com/search/users")
    }
    
    func test_downLoadImage() {
      let downloadTask = imageView.loadImage(urlString:"acd")
        XCTAssertTrue(downloadTask.state == .running)
    }
}
