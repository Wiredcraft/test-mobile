//
//  QRSeed.swift
//  QRGenerator
//
//  Created by 杨志超 on 2018/1/19.
//  Copyright © 2018年 buginux. All rights reserved.
//

import Foundation

class QRSeed {
    let seed: String
    let expiresAt: Date?
    
    init(seed: String, expiresAt: Date?) {
        self.seed = seed
        self.expiresAt = expiresAt
    }
    
    init?(json: [String: AnyObject]) {
        guard let seed = json["seed"] as? String else {
            return nil
        }
        
        self.seed = seed
        self.expiresAt = json["expires_at"] as? Date
    }
}
