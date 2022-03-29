//
//  JSONCoder.swift
//  MobileTest
//
//  Created by yanjun lee on 2022/3/26.
//

import Foundation

/// Codble
public func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    
    return decoder
}

public func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    
    return encoder
}
