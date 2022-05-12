//
//  Cancellable.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/9.
//


import Foundation

/// An `Cancellable` is userd to provide interface of ability for customers
/// to cancel specific actions
public protocol Cancellable {
    /// Cancel specific action of a `Cancellable`
    func cancel()
}
