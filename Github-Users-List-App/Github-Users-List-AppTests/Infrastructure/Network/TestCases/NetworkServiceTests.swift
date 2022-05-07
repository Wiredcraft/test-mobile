//
//  NetworkServiceTests.swift
//  GitHub-Users-List-AppTests
//
//  Created by 邹奂霖 on 2022/5/6.
//

import XCTest
@testable import GitHub_Users_List_App
class NetworkServiceTests: XCTestCase {
    var sut: DefaultNetworkService!
    var networkConfig: NetworkConfigurable!
    override func setUpWithError() throws {
        try super.setUpWithError()
        networkConfig = MockNetworkConfigurable()
    }

    override func tearDownWithError() throws {
        sut = nil
        networkConfig = nil
        try super.tearDownWithError()
    }

    func testNetworkService_whenMockDataPassed_returnProperResponse() {
        // given
        let expectation = self.expectation(description: "Should return correct data")
        let expectedResponseData = "Response Data".data(using: .utf8)!
        sut = DefaultNetworkService(config: networkConfig, sessionManager: MockNetworkSessionManager(response: nil, data: expectedResponseData, error: nil))
        // when
        _ = sut.request(endPoint: MockEndpoint<MockDataModel>(path: "https://exampleAPI.com", method: .get), completion: { result in
            guard let response = try? result.get() else {
                XCTFail("should return proper response")
                return
            }
            XCTAssertEqual(expectedResponseData, response)
            expectation.fulfill()
        })
        // then
        waitForExpectations(timeout: 0.1)
    }

    func testNetworkService_passError_returnErrorResponse() {
        // given
        let expectation = self.expectation(description: "Should return correct data")
        let expectatedError = NSError(domain: "GitHub_Users_Lists_App", code: NSURLErrorCancelled)
        sut = DefaultNetworkService(config: networkConfig, sessionManager: MockNetworkSessionManager(response: nil, data: nil, error: expectatedError))

        // when
        _ = sut.request(endPoint: MockEndpoint<MockDataModel>(path: "https://exampleAPI.com", method: .get), completion: { result in
            do {
                try _ = result.get()
                XCTFail("should not happen")
            } catch {
                guard case NetworkError.cancelled = error else {
                    XCTFail("NetworkError.cancelled not found")
                    return
                }

                expectation.fulfill()
            }
        })
        // then
        waitForExpectations(timeout: 0.1)
    }

    func testNetworkService_passInvalidPath_throwURLGenerationError() {
        let expectation = self.expectation(description: "Should return correct data")
        let expectatedError = NSError(domain: "GitHub_Users_Lists_App", code: NSURLErrorCancelled)
        sut = DefaultNetworkService(config: networkConfig, sessionManager: MockNetworkSessionManager(response: nil, data: nil, error: expectatedError))
        let invalidEndpoint = MockEndpoint<MockDataModel>(path: "-;@,?:ą", method: .get)
        // when
        _ = sut.request(endPoint: invalidEndpoint, completion: { result in
            do {
                try _ = result.get()
                XCTFail("Should throw URLGenerationError")
            } catch {
                guard case NetworkError.URLGeneration = error else {
                    XCTFail("Should throw URLGenerationError")
                    return
                }
                expectation.fulfill()
            }
        })
        // then
        waitForExpectations(timeout: 0.1)
    }
}
