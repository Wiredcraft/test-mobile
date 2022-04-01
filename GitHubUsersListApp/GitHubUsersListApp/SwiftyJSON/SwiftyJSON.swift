//
//  SwiftyJSON.swift
//  CJWProject
//
//  Created by Joy Cheng on 2022/3/31.
//

import Foundation
import SwiftyJSON

public typealias JSON = SwiftyJSON.JSON

public protocol SwiftyJSONAble {
    init?(_ jsonData: JSON)
}
extension Bool: SwiftyJSONAble {
    public init?(_ jsonData: JSON) {
        self = jsonData.boolValue
    }
}
extension String: SwiftyJSONAble {
    public init?(_ jsonData: JSON) {
        self = jsonData.stringValue
    }
}
