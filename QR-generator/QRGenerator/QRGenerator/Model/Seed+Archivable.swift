//
//  Seed+Archivable.swift
//  QRGenerator
//
//  Created by tripleCC on 2018/1/24.
//  Copyright © 2018年 tripleCC. All rights reserved.
//

import Foundation
import ObjectMapper

extension Seed: Archivable {
    func archive() -> [String : Any] {
        return toJSON()
    }
    
    init?(unarchive: [String : Any]?) {
        guard let values = unarchive else { return nil }
        let object = Mapper<Seed>().map(JSON: values)
        seed = object?.seed
        expiresAt = object?.expiresAt
    }
    
    
    struct SeedStatic {
        static let path: String = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first! + "/Seed"
    }
    
    static func unarchiveFromDisk() -> Seed? {
        return unarchiveObjectWithFile(path: SeedStatic.path)
    }
    
    func archiveToDisk() {
        archiveObject(object: self, toFile: SeedStatic.path)
    }
}
