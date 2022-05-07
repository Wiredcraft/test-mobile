//
//  AppFlowCoordinator.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/7.
//

import UIKit
class AppFlowCoordinator {
    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        
    }
}
