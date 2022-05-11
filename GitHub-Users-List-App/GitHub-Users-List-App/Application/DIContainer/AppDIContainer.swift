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
        var headers = ["User-Agent":"GitHub-Users-List-App"]
        if let token = configuration.accessToken {
            headers["Authorization"] = token
        }
        let config = ApiDataNetworkConfig(baseURL: URL(string: configuration.apiBaseURL)!, headers: headers)

        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()

    // MARK: - Scenes
    func makeUsersDIContainer() -> UsersListDIContainer {
        let dependencies = UsersListDIContainer.Dependencies(apiDataTransferService: apiDataTransferService)
        return UsersListDIContainer(dependencies: dependencies)
    }
}
