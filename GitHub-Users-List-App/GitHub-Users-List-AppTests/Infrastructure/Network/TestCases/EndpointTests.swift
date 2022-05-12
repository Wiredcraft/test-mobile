//
//  EndpointTests.swift
//  GitHub-Users-List-AppTests
//
//  Created by 邹奂霖 on 2022/5/6.
//

import XCTest
@testable import GitHub_Users_List_App
class EndpointTests: XCTestCase {
    var sut: MockEndpoint<MockDataModel>!
    // MARK: - Life Cycle
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    // MARK: - Given
    func givenInvalidURLEndpoint() {
        sut = MockEndpoint(path: "-;@,?:ą", method: .get)
    }

    func givenValidURLEndPoint() {
        sut = MockEndpoint(path: "hello", method: .get)
    }
    // MARK: - Tests
    func testEndpoint_init() {
        let expectedPath = "hello"
        let expectedMethod: HTTPMethodType = .get
        sut = MockEndpoint(path: expectedPath, method: expectedMethod)
        XCTAssertEqual(sut.path, expectedPath)
        XCTAssertEqual(sut.method, expectedMethod)
    }

    func testURLWithConfig_passInvalidURL_throwURLGenerationError() {
        givenInvalidURLEndpoint()
        let config = MockNetworkConfigurable()
        do {
            let _ = try sut.url(with: config)
            XCTFail("Should throw requestGenerationError")
        } catch {
            guard case RequestGenerationError.components = error else {
                XCTFail("Should throw requestGenerationError")
                return
            }
        }
    }

    func testURLRequest_passInvalidURL_throwURLGenerationError() {
        givenInvalidURLEndpoint()
        let config = MockNetworkConfigurable()
        do {
            let _ = try sut.urlRequest(with: config)
            XCTFail("Should throw requestGenerationError")
        } catch {
            guard case RequestGenerationError.components = error else {
                XCTFail("Should throw requestGenerationError")
                return
            }
        }
    }

    func testURLRequest_PassBodyParameter_encodeToHTTPBody() throws {
        givenValidURLEndPoint()
        let bodyParameters = ["testkey": "testValue"]
        sut.bodyParamaters = bodyParameters
        let config = MockNetworkConfigurable()
        let request = try sut.urlRequest(with: config)
        let expected = bodyParameters.queryString.data(using: String.Encoding.ascii, allowLossyConversion: true)
        XCTAssertTrue(request.httpBody == expected)
    }

    func testURL_passQueryParameters_transferToQueryItems() throws {
        givenValidURLEndPoint()
        let queryParamters = ["testkey": "testValue"]
//        sut.queryParameters = queryParamters
        let config = MockNetworkConfigurable()
        config.queryParameters = queryParamters
        let queryItems = queryParamters.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        let url = try sut.url(with: config)
        XCTAssertTrue(URLComponents(url: url, resolvingAgainstBaseURL: true)!.queryItems!.contains(queryItems.first!))
    }
}
