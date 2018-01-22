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
    var expiresAt: TimeInterval = 0
    
    init(seed: String, expiresAt: TimeInterval) {
        self.seed = seed
        self.expiresAt = expiresAt
    }
    
    init?(json: [String: Any]) {
        guard let seed = json["seed"] as? String,
            let expiresAt = json["expires_at"] as? String else {
            return nil
        }
        
        self.seed = seed
        self.expiresAt = self.parseTimeString(expiresAt)
    }
    
    func parseTimeString(_ string: String) -> TimeInterval {
        let formatter = DateFormatter()
        
        // Format 1
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let parsedDate = formatter.date(from: string) {
            return parsedDate.timeIntervalSince1970
        }
        
        // Format 2
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:SSSZ"
        if let parsedDate = formatter.date(from: string) {
            return parsedDate.timeIntervalSince1970
        }
        
        return 0
    }
}
