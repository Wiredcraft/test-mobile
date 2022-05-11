//
//  DataTransferServiceTests.swift
//  GitHub-Users-List-AppTests
//
//  Created by 邹奂霖 on 2022/5/6.
//

import XCTest
@testable import GitHub_Users_List_App

class DataTransferServiceTests: XCTestCase {
    private enum DataTransferErrorMock: Error {
        case someError
    }
    var mockNetworkConfig: MockNetworkConfigurable!
    var mockSessionManager: MockNetworkSessionManager!
    var networkService: NetworkService!
    var mockLogger: NetworkErrorLogger!
    var mockEndpoint: MockEndpoint<MockDataModel>!
    var sut: DefaultDataTransferService!
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockNetworkConfig = MockNetworkConfigurable()
        mockEndpoint = MockEndpoint<MockDataModel>(path: "http://mock.test.com", method: .get)
    }

    override func tearDownWithError() throws {
        mockNetworkConfig = nil
        mockSessionManager = nil
        mockEndpoint = nil
        networkService = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testDTFS_passValidJSON_decodeToObject() {
        let expectation = expectation(description: "Should decode mock object")
        let expectedResponseData = #"{"name": "Hello"}"#.data(using: .utf8)
        mockLogger = NetworkErrorLoggerMock()
        mockSessionManager = MockNetworkSessionManager(response: nil, data: expectedResponseData, error: nil)
        networkService = MockNetworkService(config: mockNetworkConfig, sessionManager: mockSessionManager, logger: mockLogger)
        sut = DefaultDataTransferService(with: networkService)
        // when
        _ = sut.request(with: mockEndpoint) { result in
            do {
                let object = try result.get()
                XCTAssertEqual(object.name, "Hello")
                expectation.fulfill()
            } catch {
                XCTFail("Failed decoding object")
            }
        }
        //then
        wait(for: [expectation], timeout: 0.1)
    }

    func testDTFS_passInvalidJSON_completionWithError() {
        let expectation = expectation(description: "Should not decode mock object")
        let invalidResponseData = #"{"age": "20"}"#.data(using: .utf8)
        mockLogger = NetworkErrorLoggerMock()
        mockSessionManager = MockNetworkSessionManager(response: nil, data: invalidResponseData, error: nil)
        networkService = MockNetworkService(config: mockNetworkConfig, sessionManager: mockSessionManager, logger: mockLogger)
        sut = DefaultDataTransferService(with: networkService)
        // when
        _ = sut.request(with: mockEndpoint) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch {
                expectation.fulfill()
            }
        }
        //then
        wait(for: [expectation], timeout: 0.1)
    }

    func testDTFS_receiveBadRequest_completionWithNetworkFailureError() {
        let expectation = self.expectation(description: "Should throw network error")
        let responseData = #"{"invalidStructure": "Nothing"}"#.data(using: .utf8)!
        let response = HTTPURLResponse(url: URL(string: "test_url")!,
                                       statusCode: 500,
                                       httpVersion: "1.1",
                                       headerFields: nil)
        mockLogger = NetworkErrorLoggerMock()
        mockSessionManager = MockNetworkSessionManager(response: response, data: responseData, error: DataTransferErrorMock.someError)
        networkService = MockNetworkService(config: mockNetworkConfig, sessionManager: mockSessionManager, logger: mockLogger)
        sut = DefaultDataTransferService(with: networkService)
        _ = sut.request(with: mockEndpoint, completion: { result in
            do {
                _ = try result.get()
                XCTFail("should not happen")
            } catch let error {
                if case DataTransferError.networkFailure(NetworkError.error(statusCode: 500, data: _)) = error {
                    expectation.fulfill()
                } else {
                    XCTFail("wrong error")
                }
            }
        })
        waitForExpectations(timeout: 0.1)
    }

    func testDTFS_noDataReceived_completionWithNoDataError() {
        let expectation = self.expectation(description: "Should throw no data error")
        let response = HTTPURLResponse(url: URL(string: "test_url")!,
                                       statusCode: 200,
                                       httpVersion: "1.1",
                                       headerFields: [:])
        mockLogger = NetworkErrorLoggerMock()
        mockSessionManager = MockNetworkSessionManager(response: response, data: nil, error: nil)
        networkService = MockNetworkService(config: mockNetworkConfig, sessionManager: mockSessionManager, logger: mockLogger)
        sut = DefaultDataTransferService(with: networkService)
        _ = sut.request(with: mockEndpoint, completion: { result in
            do {
                _ = try result.get()
                XCTFail("should not happen")
            } catch let error {
                if case DataTransferError.noResponse = error {
                    expectation.fulfill()
                } else {
                    XCTFail("wrong error")
                }
            }
        })
        waitForExpectations(timeout: 0.1)
    }
}

