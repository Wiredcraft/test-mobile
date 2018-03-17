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
    
    var future: Future<T, NSError> { get }
    var state: OperationState { get }
}

/// Generic class for asyncronous operation that can be executed in a similar fashion as futures,
/// but also provides custom functionality to this application's context.
///
class AsyncOperation<T>: Operation {
    
    let future: Future<T, NSError>
    let cancellationBlock: () -> Void
    
    var state: OperationState {
        if !future.isCompleted {
            return .inProgress
        }
        return future.isFailure ? .failure : .success
    }
    
    public init(future: Future<T, NSError>, cancellationBlock: @escaping () -> Void) {
        self.future = future
        self.cancellationBlock = cancellationBlock
    }
    
    public init(future: Future<T, NSError>) {
        self.future = future
        self.cancellationBlock = { }
    }
    
    public init(_ operationBlock: @escaping (@escaping (Result<T, NSError>) -> Void) -> Void,
                cancellationBlock: @escaping () -> Void) {
        self.future = Future { complete in operationBlock { operationResult in complete(operationResult) } }
        self.cancellationBlock = cancellationBlock
    }
    
    public init(_ operationBlock: @escaping (@escaping (Result<T, NSError>) -> Void) -> Void) {
        self.future = Future { complete in operationBlock { operationResult in complete(operationResult) } }
        self.cancellationBlock = { }
    }
    
    /// TODO: Implement proper cancelling to the AsyncOperation
    ///
    func cancel() {
        cancellationBlock()
    }
}
