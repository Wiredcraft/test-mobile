//
//  WCNetworkLog.swift
//  Wiredcraft
//
//  Created by codeLocker on 2020/6/11.
//  Copyright © 2020 codeLocker. All rights reserved.
//

import UIKit
import Moya

/*
 *  print the log of the network
 *  contain request、params、header、method、response、error
 */
public class WCNetworkLog: PluginType {
    
    /// Called to modify a request before sending.
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        return request
    }

    /// Called immediately before a request is sent over the network (or stubbed).
    public func willSend(_ request: RequestType, target: TargetType) {
        
    }

    /// Called after a response has been received, but before the MoyaProvider has invoked its completion handler.
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        
    }

    /// Called to modify a result before completion.
    public func process(_ result: Result<Moya.Response, MoyaError>, target: TargetType) -> Result<Moya.Response, MoyaError> {
        /// ============================== Log ==============================
        print("🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥NETWORK🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥")
        print("🚀server：" + "\(target.baseURL)")
        print("🐞path：" + "\(target.path)")
        print("🎩header：" + "\(String(describing: target.headers ?? [String: String]()))")
        print("☕️method：" + "\(target.method.rawValue)")
        
        switch result {
        case .success(let response):
            print("📦params:")
            /// httpBody convert to string type
            print(self.parseParameter(response.request?.httpBody?.es_string() ?? ""))
            print("✅response:")
            /// response convert to dictionary type
            print(response.data.es_dictionary()?.es_formatLog(level: 0) ?? [String: Any]())
            break
        case .failure(let error):
            print("❌error:" + error.localizedDescription)
            break
        }
        return result
    }
}

extension WCNetworkLog {
    
    /// split request's parameters fragment by '&' symbol
    /// - Parameter param: all parameters‘s string
    /// - Returns: [String] the array of each parameter fragment like ["a=1", "b=2"]
    fileprivate func parseParameter(_ param: String) -> [String] {
        return param.split(separator: "&").map { (substring) -> String in
            return String.init(substring)
        }
    }
}
 
