//
//  Operation+FutureKind.swift
//  QRApp
//
//  Created by Ville Välimaa on 17/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import Foundation
import BrightFutures
import Result

/// Pass-through functions for our Operation type
///
public extension Operation {
    
    @discardableResult
    func onSuccess(callback: @escaping (T) -> Void) -> Self {
        future.onSuccess(callback: callback)
        return self
    }
    
    @discardableResult
    func onSuccess(_ executionContext: @escaping ExecutionContext, callback: @escaping (T) -> Void) -> Self {
        future.onSuccess(executionContext, callback: callback)
        return self
    }
    
    @discardableResult
    func onFailure(callback: @escaping (AppError) -> Void) -> Self {
        future.onFailure(callback: callback)
        return self
    }
    
    @discardableResult
    func onFailure(_ executionContext: @escaping ExecutionContext, callback: @escaping (AppError) -> Void) -> Self {
        future.onFailure(executionContext, callback: callback)
        return self
    }
    
    @discardableResult
    func onComplete(callback: @escaping (Result<T, AppError>) -> Void) -> Self {
        future.onComplete(callback: callback)
        return self
    }
    
    @discardableResult
    func onComplete(_ executionContext: @escaping ExecutionContext, callback: @escaping (Result<T, AppError>) -> Void) -> Self {
        future.onComplete(executionContext, callback: callback)
        return self
    }
    
    func map<U>(_ fn: @escaping (T) -> U) -> AsyncOperation<U> {
        return AsyncOperation(future: future.map(fn))
    }
    
    func flatMap<U>(_ fn: @escaping (T) -> AsyncOperation<U>) -> AsyncOperation<U> {
        let newFuture = future.flatMap { value -> Future<U, AppError> in
            let op = fn(value)
            return op.future
        }
        return AsyncOperation(future: newFuture)
    }
}

/// Extensions to the standard Future kind functionality
///
public extension Operation {
    
    func onLoadingStateChange(_ callback: @escaping (_ isInProgress: Bool) -> Void) -> Self {
        if !future.isCompleted {
            callback(true)
        }
        
        _ = onComplete(DispatchQueue.main.context){ _ in
            callback(false)
        }
        
        return self
    }
}
