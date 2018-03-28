//
//  Operation.swift
//  QRApp
//
//  Created by Ville Välimaa on 16/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import BrightFutures
import Foundation
import Result

/// State of the operation.
///
public enum OperationState {
    case inProgress
    case success
    case failure
}

/// Something that can be cancelled.
///
public protocol Cancellable {
    func cancel()
}

public protocol Operation: Cancellable {
    associatedtype T = Any
    
    var future: Future<T, AppError> { get }
    var state: OperationState { get }
}

/// Generic class for asyncronous operation that can be executed in a similar fashion as futures,
/// but also provides custom functionality to this application's context.
///
public class AsyncOperation<T>: Operation {
    
    open let future: Future<T, AppError>
    let cancellationBlock: () -> Void
    
    open var state: OperationState {
        if !future.isCompleted {
            return .inProgress
        }
        return future.isFailure ? .failure : .success
    }
    
    public init(future: Future<T, AppError>, cancellationBlock: @escaping () -> Void) {
        self.future = future
        self.cancellationBlock = cancellationBlock
    }
    
    public init(future: Future<T, AppError>) {
        self.future = future
        self.cancellationBlock = { }
    }
    
    public init(_ operationBlock: @escaping (@escaping (Result<T, AppError>) -> Void) -> Void,
                cancellationBlock: @escaping () -> Void) {
        self.future = Future { complete in operationBlock { operationResult in complete(operationResult) } }
        self.cancellationBlock = cancellationBlock
    }
    
    public init(_ operationBlock: @escaping (@escaping (Result<T, AppError>) -> Void) -> Void) {
        self.future = Future { complete in operationBlock { operationResult in complete(operationResult) } }
        self.cancellationBlock = { }
    }
    
    public init(error: AppError) {
        self.future = Future(error: error)
        self.cancellationBlock = { }
    }
    
    public init(value: T) {
        self.future = Future(value: value)
        self.cancellationBlock = { }
    }
    
    /// TODO: Implement proper cancelling to the AsyncOperation
    ///
    open  func cancel() {
        cancellationBlock()
    }
}
