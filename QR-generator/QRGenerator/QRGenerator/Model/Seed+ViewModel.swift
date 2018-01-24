//
//  Seed+ViewModel.swift
//  QRGenerator
//
//  Created by tripleCC on 2018/1/24.
//  Copyright © 2018年 tripleCC. All rights reserved.
//

import Foundation


extension Seed {
    var expiresDate: Date? {
        return expiresAt.flatMap { ISO8601DateFormatter().date(from: $0) }
    }
}
