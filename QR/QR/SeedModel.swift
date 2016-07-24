//
//  SeedModel.swift
//  QR
//
//  Created by Samuel Zhang on 7/23/16.
//  Copyright © 2016 Samuel Zhang. All rights reserved.
//

import Foundation

public struct SeedModel: Equatable {
    let rawData: NSData
    public let seed: NSString
    public let expiredAt: Int
    
    init?(data: NSData?) {
        guard let data = data else { return nil }
        do {
            let dic = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:AnyObject]
            if let theSeed = dic?["seed"] as? NSString,
                expire = dic?["expiredAt"] as? Int {
                    seed = theSeed
                    rawData = data
                    expiredAt = expire
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    func isExpired(now: NSDate = NSDate()) -> Bool {
        return now.timeIntervalSince1970 * 1000 >= Double(expiredAt)
    }
}

public func ==(lhs: SeedModel, rhs: SeedModel) -> Bool {
    return lhs.seed == rhs.seed && lhs.expiredAt == rhs.expiredAt
}