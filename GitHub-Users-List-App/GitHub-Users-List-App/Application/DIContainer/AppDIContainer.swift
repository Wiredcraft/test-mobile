//
//  AppDIContainer.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/7.
//

import Foundation
final class AppDIContainer {
    lazy var configuration = AppConfiguration()

    lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: configuration.apiBaseURL)!)

        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()
}
