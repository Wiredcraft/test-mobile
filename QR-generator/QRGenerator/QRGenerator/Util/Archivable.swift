//
//  Archivable.swift
//  QRGenerator
//
//  Created by tripleCC on 2018/1/24.
//  Copyright © 2018年 tripleCC. All rights reserved.
//

import Foundation

public protocol Archivable {
    func archive() -> [String : Any]
    init(unarchive: [String : Any])
}

public func unarchiveObjectWithFile<T: Archivable>(path: String) -> T? {
    return (NSKeyedUnarchiver.unarchiveObject(withFile: path) as? [String : Any]).flatMap { T(unarchive: $0) }
}

public func archiveObject<T: Archivable>(object: T, toFile path: String) {
    NSKeyedArchiver.archiveRootObject(object.archive(), toFile: path)
}
