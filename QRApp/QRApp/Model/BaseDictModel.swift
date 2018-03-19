//
//  BaseDictModel.swift
//  QRApp
//
//  Created by Ville Välimaa on 17/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import Foundation

/// Base dictionary model, which is initialized with
/// dictionary and provides safe getters for its values
/// submodels.
///
public class BaseDictModel {
    
    private var dict: [String : Any]
    
    public init(_ dict: [String : Any]) {
        self.dict = dict
    }
    
    // ----------------------------------------------------------------
    // MARK: Getters into the dictionary
    
    public func get<T>(_ key: String, defaultValue: T) -> T {
        return self.dict[key] as? T ?? defaultValue
    }
    
    public func get<T>(_ key: String) -> T? {
        return self.dict[key] as? T
    }
    
    public subscript(key: String) -> Any? {
        return dict[key]
    }
    
    public func stringOrEmpty(_ key: String) -> String {
        return get(key, defaultValue: "")
    }
    
    public func string(_ key: String) -> String? {
        return get(key)
    }
    
    public func intOrZero(_ key: String) -> Int {
        return get(key, defaultValue: 0)
    }
    
    public func int(_ key: String) -> Int? {
        return get(key)
    }
    
    public func doubleOrZero(_ key: String) -> Double {
        return get(key, defaultValue: 0)
    }
    
    public func double(_ key: String) -> Double? {
        return get(key)
    }
    
    public func boolOrFalse(_ key: String) -> Bool {
        return get(key, defaultValue: false)
    }
    
    public func bool(_ key: String) -> Bool? {
        return get(key)
    }
    
    public func subModel(_ key: String) -> BaseDictModel {
        return BaseDictModel(get(key, defaultValue: [:]))
    }
}
