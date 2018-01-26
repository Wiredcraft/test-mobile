//
//  QRGeneratorProvider.swift
//  QRGenerator
//
//  Created by tripleCC on 2018/1/23.
//  Copyright © 2018年 tripleCC. All rights reserved.
//

import Foundation
import Moya

public enum QRGenerator {
    case seed
    case none
}

extension QRGenerator: TargetType {
    public var method: Moya.Method {
        switch self {
        case .seed:
            return .get
        default:
            return .get
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    public var baseURL: URL {
        return URL(string: "http://localhost:3000")!
    }
    
    public var sampleData: Data {
        switch self {
        case .seed:
            return try! JSONSerialization.data(withJSONObject: [
                "seed" : "1234567890",
                "expiresAt" : "2018-01-23T18:41:55+08:00"
            ], options: .prettyPrinted)
        default:
            return Data()
        }
    }
    
    public var task: Task {
        switch self {
        case .seed:
            return .requestPlain
        default:
            return .requestPlain
        }
    }
    
    public var path: String {
        switch self {
        case .seed:
            return "seed"
        default:
            return "none"
        }
    }
}

let QRGeneratorProvider = MoyaProvider<QRGenerator>(endpointClosure: QRGeneratorEndpointClosure(),
                                                    manager: QRGeneratorManagerGenerator(),
                                                    plugins: QRGeneratorProviderPlugins())
private func QRGeneratorEndpointClosure() -> ((QRGenerator) -> Endpoint<QRGenerator>) {
    return { (target) -> Endpoint<QRGenerator> in
        return MoyaProvider.defaultEndpointMapping(for: target)
    }
}

private func QRGeneratorManagerGenerator() -> Manager {
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
    let manager = Manager(configuration: configuration)
    manager.startRequestsImmediately = false
    
    return manager
}

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data
    }
}

private func QRGeneratorProviderPlugins() -> [PluginType] {
    return [
        NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter),
        NetworkActivityPlugin { (type, target) in
            switch type {
            case .began:
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            case .ended:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    ]
}
