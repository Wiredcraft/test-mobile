//
//  QRSeedService.swift
//  QRGenerator
//
//  Created by 杨志超 on 2018/1/19.
//  Copyright © 2018年 buginux. All rights reserved.
//

import Foundation
import Alamofire

class QRSeedService {
    class func fetchQRSeed(withCompletion completion: @escaping (QRSeed?) -> ()) {
        let cache = QRSeedCache()
        let seed = cache.readCachedSeed()
        
        // Seed is cached && not expired
        if seed != nil && Date().timeIntervalSince1970 < seed!.expiresAt {
            completion(seed)
            return
        }
        
        Alamofire.request(URL(string: "http://localhost:3000/seed")!)
        .validate()
        .responseJSON { (response) in
            guard response.result.isSuccess else {
                print("Error while fetching seed: \(String(describing: response.result.error))")
                completion(nil)
                return
            }
            
            guard let value = response.result.value as? [String: Any],
                let seed = QRSeed(json: value) else {
                print("Malformed data received from fetchSeed service")
                completion(nil)
                return
            }
            
            cache.save(seed: seed)
            completion(seed)
        }
    }
}
