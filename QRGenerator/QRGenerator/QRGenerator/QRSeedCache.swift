//
//  QRSeedCache.swift
//  QRGenerator
//
//  Created by 杨志超 on 2018/1/19.
//  Copyright © 2018年 buginux. All rights reserved.
//

import Foundation

class QRSeedCache {
    enum QRSeedCacheKey: String {
        case seed
        case expiresAt
    }
    
    func readCachedSeed() -> QRSeed? {
        let seed = UserDefaults.standard.string(forKey: QRSeedCacheKey.seed.rawValue)
        let expiresAt = UserDefaults.standard.double(forKey: QRSeedCacheKey.expiresAt.rawValue)
        
        if let seed = seed {
            return QRSeed(seed: seed, expiresAt: expiresAt)
        }
        
        return nil
    }
    
    func save(seed: QRSeed?) {
        guard let seed = seed else { return }
        
        UserDefaults.standard.set(seed.seed, forKey: QRSeedCacheKey.seed.rawValue)
        UserDefaults.standard.set(seed.expiresAt, forKey: QRSeedCacheKey.expiresAt.rawValue)
        UserDefaults.standard.synchronize()
    }
}
