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
    let expiresAt: TimeInterval
    
    init(seed: String, expiresAt: TimeInterval) {
        self.seed = seed
        self.expiresAt = expiresAt
    }
    
    init?(json: [String: AnyObject]) {
        guard let seed = json["seed"] as? String,
            let expiresAt = json["expires_at"] as? TimeInterval else {
            return nil
        }
        
        self.seed = seed
        self.expiresAt = expiresAt
    }
}
