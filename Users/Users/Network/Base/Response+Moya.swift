//
//  Response+Moya.swift
//  Users
//
//  Created by ivan on 2021/1/31.
//  Copyright © 2021 none. All rights reserved.
//

import Foundation

import Moya

// success response
struct GHResponse<ResultType: Codable>: Decodable {
    let code: Int? // bussiness code is necessary
    let result: ResultType?
    static func from(data: Data) throws -> GHResponse<ResultType> {
        let result = try JSONDecoder().decode(ResultType.self, from: data)
        return GHResponse(code: 0, result: result)
    }
}

// error
enum NetworkError: CustomStringConvertible {
    case failNetwork
    case unauthorized
    case noData
    case otherError(msg: String)

    var description: String {
        switch self {
        case .failNetwork:
            return "network fail"
        case .noData:
            return "no Data"
        case .unauthorized:
            return "you are unauthorized"
        case let .otherError(msg):
            return "\(msg)"
        }
    }
}

enum NetworkResult<ResultType: Codable> {
    case success(GHResponse<ResultType>)
    case error(NetworkError)
}
