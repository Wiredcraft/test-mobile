//
//  QRMembership.swift
//  QRApp
//
//  Created by Ville Välimaa on 19/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import Foundation

class QRMembership: NSObject, NSCoding {
    
    private static let SEED_KEY = "seed"
    private static let EXPIRES_AT_KEY = "expires_at"
    
    let seed: String
    let expires_at: String
    
    public init(seed: String, expires_at: String) {
        self.seed = seed
        self.expires_at = expires_at
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(seed, forKey: QRMembership.SEED_KEY)
        aCoder.encode(expires_at, forKey: QRMembership.EXPIRES_AT_KEY)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard
            let seed = aDecoder.decodeObject(forKey: QRMembership.SEED_KEY) as? String,
            let expires_at = aDecoder.decodeObject(forKey: QRMembership.EXPIRES_AT_KEY) as? String else { return nil }
        self.init(seed: seed, expires_at: expires_at)
    }
}

/// Implements simple "cache" to NSUserDefaults,
/// which stores the membership data. Should not
/// be used for larger amounts of data.
///
extension QRUserDefaults {
    
    var qrMembershipKey: String { return "qrMembership" }
    
    var qrMembershipInStorage: QRMembership? {
        get {
            guard let data: Data = get(qrMembershipKey) else { return nil }
            let membership = NSKeyedUnarchiver.unarchiveObject(with: data) as? QRMembership
            return membership
        }
        set {
            guard let value = newValue else {
                set(nil, qrMembershipKey)
                return
            }
            let data = NSKeyedArchiver.archivedData(withRootObject: value)
            set(data, qrMembershipKey)
        }
    }
}
