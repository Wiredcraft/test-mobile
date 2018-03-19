//
//  OperationTests.swift
//  QRAppTests
//
//  Created by Ville Välimaa on 19/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import XCTest
@testable import QRApp

class OperationTests: QRBaseTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testOperationWithImmidiateValue() {
        let op = AsyncOperation<Int>(value: 88)
        XCTAssertTrue(op.state == .success)
        XCTAssertFalse(op.state == .failure)
        XCTAssertFalse(op.state == .inProgress)
        
        var successTriggered = false
        var completeTriggered = false
        var failureTriggered = false
        var resultValue: Int? = nil
        op.onSuccess { value in resultValue = value; successTriggered = true }
        op.onFailure { error in failureTriggered = true }
        op.onComplete { _ in completeTriggered = true }
        
        waitForTimeoutWithCondition(1, condition: successTriggered && completeTriggered && !failureTriggered)
        
        XCTAssertTrue(successTriggered)
        XCTAssertTrue(completeTriggered)
        XCTAssertFalse(failureTriggered)
        XCTAssertEqual(resultValue, 88)
    }
    
    func testOperationWithFailureValue() {
        let op = AsyncOperation<Void>(error: AppError.makeUnknownError())
        XCTAssertFalse(op.state == .success)
        XCTAssertTrue(op.state == .failure)
        XCTAssertFalse(op.state == .inProgress)
        
        var successTriggered = false
        var completeTriggered = false
        var failureTriggered = false
        var errorValue: AppError? = nil
        op.onSuccess { _ in successTriggered = true }
        op.onFailure { error in errorValue = error; failureTriggered = true }
        op.onComplete { _ in completeTriggered = true }
        
        waitForTimeoutWithCondition(1, condition: !successTriggered && completeTriggered && failureTriggered)
        
        XCTAssertFalse(successTriggered)
        XCTAssertTrue(completeTriggered)
        XCTAssertTrue(failureTriggered)
        XCTAssertEqual(errorValue?.errorDescription, AppError.makeUnknownError().errorDescription)
    }
    
    func testOperationMap_success() {
        let op = AsyncOperation<Int>(value: 88)
        let expectation = self.expectation(description: "\(#function)")
        var mappedString: String? = nil
        
        op.map { value in
            return "hello_world"
        }.onSuccess { value in
            mappedString = value
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            XCTAssertEqual("hello_world", mappedString)
        }
    }
    
    func testOperationMap_failure() {
        let op = AsyncOperation<Void>(error: AppError.makeUnknownError())
        let expectation = self.expectation(description: "\(#function)")
        var mappedError: AppError? = nil
        
        op.map { value in
            return "hello_world"
        }.onFailure { error in
            mappedError = error
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            XCTAssertNotNil(mappedError)
        }
    }
    
    func testOperationFlatMap_success() {
        let op = AsyncOperation<Int>(value: 88)
        let expectation = self.expectation(description: "\(#function)")
        var mappedString: String? = nil
        
        op.flatMap { number in
            return AsyncOperation<String>(value: "hello_world")
        }.onSuccess { value in
            mappedString = value
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            XCTAssertEqual("hello_world", mappedString)
        }
    }
    
    func testOperationFlatMap_failure() {
        let op = AsyncOperation<Int>(value: 88)
        let expectation = self.expectation(description: "\(#function)")
        var errorValue: AppError? = nil
        
        op.flatMap { number in
            return AsyncOperation<String> { complete in
                complete(.failure(AppError.makeUnknownError()))
            }
        }.onFailure { error in
            errorValue = error
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            XCTAssertNotNil(errorValue)
        }
    }

}
