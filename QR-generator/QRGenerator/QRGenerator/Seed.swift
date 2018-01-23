//
//  Seed.swift
//  QRGenerator
//
//  Created by tripleCC on 2018/1/23.
//  Copyright © 2018年 tripleCC. All rights reserved.
//

import Foundation
import ObjectMapper

struct Seed: Mappable {
    var seed: String?
    var expiresAt: String?
    
    init() {
    }
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        seed        <- map["seed"]
        expiresAt   <- map["expiresAt"]
    }
}
