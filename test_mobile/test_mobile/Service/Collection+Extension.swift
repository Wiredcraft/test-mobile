//
//  Collection+Extension.swift
//  test_mobile
//
//  Created by Jun Ma on 2022/3/20.
//

import Foundation

/// validate index before getting element from collection
extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

extension MutableCollection {
    subscript(safe index: Index) -> Element? {
        get {
            indices.contains(index) ? self[index] : nil
        }
        
        set {
            if let new = newValue, indices.contains(index) {
                self[index] = new
            }
        }
    }
}
