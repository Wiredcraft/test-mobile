//
//  SeedModel.swift
//  QR
//
//  Created by Samuel Zhang on 7/23/16.
//  Copyright © 2016 Samuel Zhang. All rights reserved.
//

import Foundation

public struct SeedModel: Equatable {
    public let seed: NSString
    public let expiredAt: Int

    init?(_ cachedJson: [NSString:AnyObject]?) {
        guard let json = cachedJson else { return nil }
        if let theSeed = json["seed"] as? NSString,
            expiredTime = json["expiredAt"] as? Int {
                seed = theSeed
                expiredAt = expiredTime
        } else {
            return nil
        }
    }

    func json() -> [NSString:AnyObject] {
        return [
            "seed": seed,
            "expiredAt": expiredAt
        ]
    }

    func expireTimeout(now: NSDate = NSDate()) -> NSTimeInterval {
        return NSTimeInterval(expiredAt / 1000) - now.timeIntervalSince1970
    }
}

public func ==(lhs: SeedModel, rhs: SeedModel) -> Bool {
    return lhs.seed == rhs.seed && lhs.expiredAt == rhs.expiredAt
}