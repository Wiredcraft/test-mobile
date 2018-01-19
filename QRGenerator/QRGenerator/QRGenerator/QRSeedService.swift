//
//  QRSeedService.swift
//  QRGenerator
//
//  Created by 杨志超 on 2018/1/19.
//  Copyright © 2018年 buginux. All rights reserved.
//

import Foundation

class QRSeedService {
    class func fetchQRSeed(withCompletion completion: @escaping (QRSeed?) -> ()) {
        let cache = QRSeedCache()
        let seed = cache.readCachedSeed()
        
        // Seed is not expired
        if seed != nil && Date().timeIntervalSince1970 < seed!.expiresAt {
            completion(seed)
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            let seed = QRSeed(seed: "1234567890", expiresAt: Date().timeIntervalSince1970 + 1000)
            
            cache.save(seed: seed)
            
            completion(seed)
        }
    }
}
