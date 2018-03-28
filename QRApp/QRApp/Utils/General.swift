//
//  General.swift
//  QRApp
//
//  Created by Ville Välimaa on 17/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//


/// A helper function which makes it possible to have property declaration and configuration
/// in the same place in the source code.
///
/// Similar functionality has been also proposed for the Swift language:
/// - See: https://github.com/apple/swift-evolution/pull/346
///
func with<T>(_ value: T, fn: (T) -> Void) -> T {
    fn(value)
    return value
}
