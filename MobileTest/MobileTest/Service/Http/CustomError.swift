//
//  CustomError.swift
//  MobileTest
//
//  Created by yanjun lee on 2022/3/26.
//

import Foundation

enum CustomError: Error {
    case error(message: String)
}

extension CustomError: LocalizedError {
    var errorDescription: String?{
        switch self{
        case .error(message: let str):
            return "👿ErrorMsg: \(str)"
        }
    }
}

