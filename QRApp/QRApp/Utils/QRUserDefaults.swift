//
//  QRUserDefaults.swift
//  QRApp
//
//  Created by Ville Välimaa on 19/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import Foundation

private let _userDefaults = QRUserDefaults()

class QRUserDefaults {
    
    public class var standard: QRUserDefaults {
        return _userDefaults
    }
    
    var defaults: UserDefaults {
        return UserDefaults.standard
    }
    
    func has(_ key: String) -> Bool {
        return defaults.object(forKey: key) != nil
    }
    
    // ---------------------------------------------------
    // MARK: Convenience getters
    
    func get(_ key: String) -> String? {
        return defaults.string(forKey: key)
    }
    
    func get(_ key: String) -> Int {
        return defaults.integer(forKey: key)
    }
    
    func get(_ key: String) -> Bool {
        return defaults.bool(forKey: key)
    }
    
    func get(_ key: String) -> Date? {
        return defaults.object(forKey: key) as? Date
    }
    
    func get(_ key: String) -> Any? {
        return defaults.object(forKey: key)
    }
    
    func get(_ key: String) -> Data? {
        return defaults.data(forKey: key)
    }
    
    // ---------------------------------------------------
    // MARK: Convenience setters
    
    func set(_ value: Int, _ key: String) {
        defaults.set(value, forKey: key)
    }
    
    func set(_ value: Bool, _ key: String) {
        defaults.set(value, forKey: key)
    }
    
    func set(_ value: Any?, _ key: String) {
        defaults.set(value, forKey: key)
    }
}
