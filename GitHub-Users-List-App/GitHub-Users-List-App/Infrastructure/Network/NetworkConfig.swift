//
//  NetworkConfig.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/6.
//

import Foundation

/// Network Configurable
/// Interface for network configs
public protocol NetworkConfigurable {
    var baseURL: URL { get }

    /// Headers for request
    var headers: [String: String] { get }

    var queryParameters: [String: String] { get }
}

public struct ApiDataNetworkConfig: NetworkConfigurable {
    public let baseURL: URL
    public let headers: [String: String]
    public let queryParameters: [String: String]

     public init(baseURL: URL,
                 headers: [String: String] = [:],
                 queryParameters: [String: String] = [:]) {
        self.baseURL = baseURL
        self.headers = headers
        self.queryParameters = queryParameters
    }
}

